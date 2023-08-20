import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gas_out_app/app/screens/login/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:gas_out_app/app/helpers/dependency_injection.dart' as di;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'app/config/app_config.dart';
import 'app/config/environments.dart';
import 'app/constants/gasout_constants.dart';
import 'app/screens/home/home_screen.dart';
import 'app/screens/notification/notification_screen.dart';
import 'data/firebase_messaging/custom_firebase_messaging.dart';
import 'data/model/class_builder_model.dart';
import 'data/repositories/notification/notification_repository.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String token = "";

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  AppConfig.getInstance(config: Environment.dev);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  di.init();
  await Firebase.initializeApp();
  await CustomFirebaseMessaging().initialize();
  await CustomFirebaseMessaging().getTokenFirebase().then((getTokenString) {
    if (getTokenString != null) {
      token = getTokenString;
      print("TOKEN: " + token);
    }
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: MaterialColor(0xFFc70000, color)).copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget(
      {Key? key,
      required this.title,
      this.username,
      this.email,
      required this.client,
      required this.isConnected})
      : super(key: key);
  final String title;
  final String? username;
  final String? email;
  final MqttServerClient client;
  late bool isConnected;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  String statusText = "Status Text";
  late KFDrawerController _drawerController;
  final NotificationRepository notificationRepository =
      NotificationRepository();

  @override
  void initState() {
    super.initState();
    ClassBuilder.registerNotification(widget.email);
    ClassBuilder.registerStats();
    ClassBuilder.registerHome(
        widget.username, widget.email, widget.client, widget.isConnected);
    print(widget.username);
    print(widget.email);

    if (widget.isConnected == false) {
      _connect();
    }

    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('HomeScreen'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Página Inicial',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.home, color: Colors.white),
          page: HomeScreen(
            username: widget.username,
            email: widget.email,
            client: widget.client,
            isConnected: widget.isConnected,
          ),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Notificações',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Icon(Icons.notifications_active, color: Colors.white),
          page: NotificationScreen(
            email: widget.email,
          ),
        ),
        // KFDrawerItem.initWithPage(
        //   text: Text(
        //     'Análise Geral',
        //     style: TextStyle(color: Colors.white, fontSize: 18),
        //   ),
        //   icon: Icon(Icons.trending_up, color: Colors.white),
        //   page: StatsScreen(),
        // ),
        // KFDrawerItem.initWithPage(
        //   text: Text(
        //     'Suporte técnico',
        //     style: TextStyle(color: Colors.white, fontSize: 18),
        //   ),
        //   icon: Image.asset(
        //     "assets/images/icWhatsApp.png",
        //     color: Colors.white,
        //     width: 26,
        //     height: 26,
        //   ),
        //   onPressed: () {
        //     String urlWpp =
        //         'whatsapp://send?phone=${ConstantsSupport.phone}&text=${ConstantsSupport.message}';
        //     launchUrlString(urlWpp);
        //   },
        // ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Chat Telegram',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Image.asset(
            "assets/images/icTelegram.png",
            color: Colors.white,
            width: 26,
            height: 26,
          ),
          onPressed: () {
            String urlTg =
                'https://telegram.me/gasoutbot';
            launchUrlString(urlTg, mode: LaunchMode.externalApplication);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        menuPadding: EdgeInsets.only(left: 15),
        header: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logoPequenaBranco.png'),
                      fit: BoxFit.fitHeight,
                      opacity: 1.0),
                ),
              ),
              SizedBox(
                width: 150,
                height: 125,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: ConstantColors.primaryColor,
        ),
      ),
    );
  }

  void _connect() async {
    widget.isConnected = await mqttConnect();
  }

  // _disconnect() {
  //   setState(() {
  //     widget.isConnected = false;
  //   });
  //   widget.client.disconnect();
  // }

  Future<bool> mqttConnect() async {
    setStatus("Conectando ao MQTT Broker...");
    ByteData rootCA = await rootBundle.load('assets/certs/RootCA.pem');
    ByteData deviceCert =
        await rootBundle.load('assets/certs/DeviceCertificate.crt');
    ByteData privateKey = await rootBundle.load('assets/certs/Private.key');

    SecurityContext context = SecurityContext.defaultContext;
    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

    widget.client.securityContext = context;
    widget.client.logging(on: true);
    widget.client.keepAlivePeriod = 20;
    widget.client.port = 8883;
    widget.client.secure = true;
    widget.client.onConnected = onConnected;
    widget.client.onDisconnected = onDisconnected;
    widget.client.pongCallback = pong;
    widget.client.server = "a2adms8kafyh61-ats.iot.us-east-1.amazonaws.com";

    print("-----------::: SERVER: " + widget.client.server);

    final MqttConnectMessage connMess =
        MqttConnectMessage().withClientIdentifier("sensor_gas_1");
    widget.client.connectionMessage = connMess;

    await widget.client.connect();

    if (widget.client.connectionStatus!.state ==
        MqttConnectionState.connected) {
      print("Conectado ao AWS com sucesso.");
    } else {
      return false;
    }

    const topic = 'gas_out_topic';
    widget.client.subscribe(topic, MqttQos.atLeastOnce);

    return true;
  }

  void setStatus(String content) {
      statusText = content;
  }

  void onConnected() {
    setStatus("A conexão do cliente foi bem sucedida.");
  }

  void onDisconnected() {
    setStatus("Cliente desconectado.");
    widget.isConnected = false;
  }

  void pong() {
    print('Ping response client callback invoked');
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(199, 0, 0, .1),
  100: Color.fromRGBO(199, 0, 0, .2),
  200: Color.fromRGBO(199, 0, 0, .3),
  300: Color.fromRGBO(199, 0, 0, .4),
  400: Color.fromRGBO(199, 0, 0, .5),
  500: Color.fromRGBO(199, 0, 0, .6),
  600: Color.fromRGBO(199, 0, 0, .7),
  700: Color.fromRGBO(199, 0, 0, .8),
  800: Color.fromRGBO(199, 0, 0, .9),
  900: Color.fromRGBO(199, 0, 0, 1),
};
