import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gas_out_app/app/screens/login/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:gas_out_app/app/helpers/dependency_injection.dart' as di;
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

  AppConfig.getInstance(config: Environment.prod);

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
      required this.email})
      : super(key: key);
  final String title;
  final String? username;
  final String email;

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
        widget.username, widget.email);
    print(widget.username);
    print(widget.email);

    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('HomeScreen'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Página Inicial',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.home, color: Colors.white),
          page: HomeScreen(
            username: widget.username,
            email: widget.email
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
        KFDrawerItem.initWithPage(
          text: Text(
            'Suporte técnico',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Image.asset(
            "assets/images/icWhatsApp.png",
            color: Colors.white,
            width: 26,
            height: 26,
          ),
          onPressed: () {
            String urlWpp =
                'whatsapp://send?phone=${ConstantsSupport.phone}&text=${ConstantsSupport.message}';
            launchUrlString(urlWpp);
          },
        ),
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

  void setStatus(String content) {
      statusText = content;
  }
}