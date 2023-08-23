import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:gas_out_app/app/constants/gasout_constants.dart';

import '../../../data/model/room/room_response_model.dart';
import '../../../data/repositories/notification/notification_repository.dart';
import '../../../main.dart';
import '../../helpers/global.dart';
import '../../stores/controller/room/room_controller.dart';
import '../detail/details_screen.dart';

class HomeScreen extends KFDrawerContent {
  final String? username;
  final String? email;

  HomeScreen({Key? key, this.username, this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int mqttSensorValue = 0;

  RoomController _roomController = RoomController();

  final NotificationRepository notificationRepository =
      NotificationRepository();

  @override
  void initState() {
    super.initState();
    _getUserRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        body: _body(),
      );
    });
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      child: Material(
                        shadowColor: Colors.transparent,
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(Icons.menu, color: Colors.black, size: 30),
                          onPressed: widget.onMenuPressed,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      child: Material(
                        shadowColor: Colors.transparent,
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            _showLogOutAlertDialog(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginScreen()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _title(),
                    SizedBox(height: 28),
                    _topLogo(),
                    SizedBox(height: 30),
                    _shortDescription(),
                    SizedBox(height: 30),
                    _roomPicker(),
                  ],
                ),
                Column(
                  children: _roomController.roomList!
                      .map((room) => _streamBuilderMqtt(room))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _streamBuilderMqtt(DataRoom room) {
    List<MqttReceivedMessage<MqttMessage>>? list;

    return StreamBuilder(
      initialData: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final mqttReceivedMessages =
              snapshot.data as List<MqttReceivedMessage<MqttMessage>>;
          final recMessBytes =
              mqttReceivedMessages[0].payload as MqttPublishMessage;
          final recMessString = MqttPublishPayload.bytesToStringAsString(
              recMessBytes.payload.message);

          bool alarmOn = false;
          bool notificationOn = false;
          bool sprinklersOn = false;

          final sensorValue =
              json.decode(recMessString)['message']['sensorValue'];
          final roomName = json.decode(recMessString)['message']['roomName'];
          final userEmail = json.decode(recMessString)['message']['email'];

          mqttSensorValue = (sensorValue / 10.0).toInt();
          print(mqttSensorValue);

          if (room.name.toString().toLowerCase() ==
                  roomName.toString().toLowerCase() &&
              room.userEmail.toLowerCase() ==
                  userEmail.toString().toLowerCase()) {
            if (mqttSensorValue > 0 && mqttSensorValue < 52) {
              alarmOn = false;
              notificationOn = true;
              sprinklersOn = false;
            } else {
              alarmOn = true;
              notificationOn = true;
              sprinklersOn = false;
            }

            _generateNotification(mqttSensorValue);

            _roomController.sendRoomSensorValue(room.name, widget.email!,
                alarmOn, notificationOn, sprinklersOn, mqttSensorValue);
          }
        }

        return Container();
      },
    );
  }

  // CARREGA A LISTA DE COMODOS QUANDO INICIA A TELA
  Future<void> _generateNotification(int mqttReceivedValue) async {
    roomController.getUserRooms(widget.email!, "");
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }

    text = text.toLowerCase();
    text = text[0].toUpperCase() + text.substring(1);

    return text;
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        "Olá, ${(_capitalizeFirstLetter(widget.username!)).split(' ')[0]}!",
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _topLogo() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      alignment: Alignment.center,
      child: Image(
        image: AssetImage('assets/images/logoPequena.png'),
        width: 250,
      ),
    );
  }

  Widget _shortDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        "Faça o controle de vazamento de gás em seu ambiente residencial e/ou industrial.",
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _roomPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Escolha um cômodo",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          _roomPickerList(),
        ],
      ),
    );
  }

  Widget _roomPickerList() {
    if (_roomController.roomList == null || _roomController.roomList!.isEmpty) {
      return CircularProgressIndicator(
          color: ConstantColors.primaryColor.withOpacity(0.8));
    } else {
      return Container(
        child: GridView.count(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          // crossAxisSpacing: 0,
          // mainAxisSpacing: 0,
          crossAxisCount: 2,
          children: _roomController.roomList!
              .map((room) => _listItem(
                  _buildRoomImage(room.name.toString()),
                  room.name,
                  room.sensorValue,
                  0,
                  _buildRoomIcon(room.name.toString())))
              .toList(),
        ),
      );
    }
  }

  String _buildRoomNameShown(String text) {
    text = text.toLowerCase();
    text = _capitalizeFirstLetter(text);
    return _capitalizeFirstLetter(text.split('_').last);
  }

  AssetImage _buildRoomIcon(String text) {
    text = roomNameEnumToPath(text);
    return AssetImage('assets/images/icon-$text.png');
  }

  String _buildRoomImage(String text) {
    text = roomNameEnumToPath(text);
    return 'assets/images/$text.jpg';
  }

  String roomNameEnumToPath(String text) {
    text = text.toLowerCase();
    text = text.replaceAll(RegExp(r'[áàâã]', caseSensitive: false), r'a');
    text = text.replaceAll(RegExp(r'[éèê]', caseSensitive: false), r'e');
    text = text.replaceAll(RegExp(r'[íï]', caseSensitive: false), r'i');
    text = text.replaceAll(RegExp(r'[óòôõ]', caseSensitive: false), r'o');
    text = text.replaceAll(RegExp(r'[úùû]', caseSensitive: false), r'u');
    text = text.replaceAll(RegExp(r'[ç]', caseSensitive: false), r'c');
    text = text.replaceAll(RegExp(r'[_]', caseSensitive: false), r'-');
    return text;
  }

  _getUserRooms() async {
    await _roomController.getUserRooms(widget.email, "");
  }

  _showLogOutAlertDialog(BuildContext context) {
    Widget cancelaButton = TextButton(
      child: Text("Cancelar", style: GoogleFonts.muli(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Sair", style: GoogleFonts.muli(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção!", style: GoogleFonts.muli(fontSize: 24)),
      content: Text("Deseja realmente sair da sua conta?",
          style: GoogleFonts.muli(fontSize: 20)),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _listItem(String imgpath, String roomName, int averageValue,
      int maxValue, AssetImage icon) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsScreen(
                    imgPath: imgpath,
                    averageValue: averageValue,
                    maxValue: maxValue,
                    totalHours: monitoringController.monitoringTotalHours,
                    email: widget.email,
                    roomName: roomName,
                  )));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: ConstantColors.primaryColor.withOpacity(0.8),
          ),
          // color: ConstantColors.primaryColor.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 30),
            child: Column(
              children: [
                Container(
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: icon, fit: BoxFit.cover)),
                ),
                SizedBox(height: 10),
                Text(
                  _buildRoomNameShown(roomName.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //   child: Stack(children: [
    //     InkWell(
    //       onTap: () {
    //         Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context) => DetailsScreen(
    //                   imgPath: imgpath,
    //                   averageValue: averageValue,
    //                   maxValue: maxValue,
    //                   totalHours: monitoringController.monitoringTotalHours,
    //                   email: widget.email,
    //                   roomName: stringPath,
    //                 )));
    //       },
    //       child: Stack(alignment: Alignment.center, children: [
    //         Container(
    //           width: 130,
    //           height: 130,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(25),
    //             color: ConstantColors.primaryColor
    //                 .withOpacity(0.8), // image: DecorationImage(
    //             //     image: AssetImage(imgpath), fit: BoxFit.cover, opacity: 0.96),
    //           ),
    //         ),
    //         Column(
    //           children: [
    //             SizedBox(height: 20),
    //             Container(
    //               height: 60.0,
    //               width: 60.0,
    //               decoration: BoxDecoration(
    //                   image: DecorationImage(image: icon, fit: BoxFit.cover)),
    //             ),
    //             SizedBox(height: 15),
    //             Container(
    //               alignment: Alignment.center,
    //               width: 120,
    //               child: Text(stringPath,
    //                   style: TextStyle(
    //                       fontSize: 16,
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold)),
    //             )
    //           ],
    //         ),
    //       ]),
    //     )
    //   ]),
    // );
  }
}
