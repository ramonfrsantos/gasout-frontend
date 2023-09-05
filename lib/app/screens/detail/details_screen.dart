import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/gasout_constants.dart';
import '../../helpers/global.dart';

class DetailsScreen extends StatefulWidget {
  final imgPath;
  final int nameId;
  final String nameDescription;

  late int gasSensorValue = 0;
  late int umiditySensorValue = 0;
  late int totalHours = 0;
  late String email = "";

  late bool notificationOn = false;
  late bool alarmOn = false;
  late bool sprinklersOn = false;

  DetailsScreen(
      {Key? key,
      this.imgPath,
      required this.nameId,
      required this.gasSensorValue,
      required this.umiditySensorValue,
      required this.totalHours,
      required this.email,
      required this.nameDescription})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // SETA O VALOR DOS BOOLEANOS DOS SWITCHES
    setValues();

    super.initState();
  }

  setValues() async {
    await roomController.getUserRooms(widget.email, widget.nameId);

    setState(() {
      widget.gasSensorValue = roomController.roomList![0].gasSensorValue;
      widget.umiditySensorValue = roomController.roomList![0].umiditySensorValue;

      widget.notificationOn = roomController.roomList![0].notificationOn;
      widget.alarmOn = roomController.roomList![0].alarmOn;
      widget.sprinklersOn = roomController.roomList![0].sprinklersOn;

      widget.email = roomController.roomList![0].user!.email!;

      print("NOTIFICATION: " + widget.notificationOn.toString());
      print("ALARM: " + widget.alarmOn.toString());
      print("SPRINKLERS: " + widget.sprinklersOn.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
          body: roomController.roomList!.length > 0
              ? Stack(
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.height - 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.imgPath),
                              fit: BoxFit.cover)),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: new Row(
                        children: <Widget>[
                          new IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                          SizedBox(width: 15)
                        ],
                      ),
                    ),
                    new Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: new Column(
                              children: <Widget>[
                                SizedBox(height: 28),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _listItemStats(
                                      imgpath: 'assets/images/notification.png',
                                      name: "Notificações",
                                      value: widget.notificationOn,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.notificationOn = value;
                                          // salvar switch
                                          roomController.updateSwitches(
                                              widget.email,
                                              widget.nameId,
                                              value,
                                              widget.alarmOn,
                                              widget.sprinklersOn);
                                        });
                                      },
                                    ),
                                    _listItemStats(
                                      imgpath: 'assets/images/siren.png',
                                      name: "Alarme",
                                      value: widget.alarmOn,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.alarmOn = value;
                                          // salvar switch
                                          roomController.updateSwitches(
                                              widget.email,
                                              widget.nameId,
                                              widget.notificationOn,
                                              value,
                                              widget.sprinklersOn);
                                        });
                                      },
                                    ),
                                    _listItemStats(
                                      imgpath: 'assets/images/sprinkler.png',
                                      name: "Sprinklers",
                                      value: widget.sprinklersOn,
                                      onChanged: (value) {
                                        // VERIFICA SE OS SPRINKLERS ESTÃO OU NÃO ATIVOS
                                        widget.sprinklersOn == true
                                            ? _showAlertDialog(context)
                                            : setState(() {
                                                widget.sprinklersOn = value;
                                                // salvar switch
                                                roomController.updateSwitches(
                                                    widget.email,
                                                    widget.nameId,
                                                    widget.notificationOn,
                                                    widget.alarmOn,
                                                    value);
                                              });
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child: Divider(
                                      color: Colors.black26,
                                    )),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Total de horas monitoradas",
                                        style: new TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                      Spacer(),
                                      Text(
                                        monitoringController
                                            .monitoringTotalHours
                                            .toString(),
                                        style: new TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Nível de gás detectado",
                                        style: new TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                      Spacer(),
                                      Text(
                                        widget.gasSensorValue.toString() +
                                            "%",
                                        style: new TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Nível de umidade",
                                        style: new TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                      Spacer(),
                                      Text(
                                        widget.umiditySensorValue.toString() +
                                            "%",
                                        style: new TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 5, left: 20, right: 20),
                                  child: Divider(
                                    color: Colors.black26,
                                  ),
                                ),
                                _monitoring()
                              ],
                            ),
                          )),
                    )
                  ],
                )
              : CircularProgressIndicator(
                  color: ConstantColors.primaryColor.withOpacity(0.8)));
    });
  }

  Widget _monitoring() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 24),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Text(
                    "Horas de monitoramento",
                    style: new TextStyle(color: Colors.black87),
                  ),
                  Spacer(),
                  Switch(
                    value: monitoringController.activeMonitoring,
                    onChanged: (value) {
                      setState(() {
                        monitoringController.activeMonitoring = value;

                        const oneHour = const Duration(seconds: 10);

                        Timer.periodic(
                          oneHour,
                          (Timer timer) {
                            if (monitoringController.activeMonitoring) {
                              monitoringController.monitoringTotalHours++;
                            } else {
                              timer.cancel();
                            }
                          },
                        );
                      });
                    },
                    activeColor: ConstantColors.primaryColor,
                  ),
                ],
              ),
              Text(
                'Reinicia a contagem de horas totais de monitoramento.',
                style: TextStyle(fontSize: 12.5, color: Colors.black38),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _listItemStats({
    required String imgpath,
    required String name,
    required bool value,
    Function(bool value)? onChanged,
  }) {
    return Container(
      width: 105,
      height: 135,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: value == true
              ? ConstantColors.primaryColor
              : ConstantColors.thirdColor),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Image(
              image: AssetImage(imgpath),
              width: 45,
              height: 45,
              color: value == true ? Colors.white : Colors.white),
          SizedBox(height: 10),
          Text(name,
              style: TextStyle(
                  fontSize: 14,
                  color: value == true ? Colors.white : Colors.white)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
          )
        ],
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    Widget cancelaButton = TextButton(
      child: Text("Cancelar", style: GoogleFonts.muli(fontSize: 16)),
      onPressed: () {
        // SE NÃO CONFIRMA, SPRINKLERS MANTÉM LIGADOS
        setState(() {
          widget.sprinklersOn = true;
        });
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Continuar", style: GoogleFonts.muli(fontSize: 16)),
      onPressed: () {
        // SE CONFIRMA, SPRINKLERS DESLIGADOS
        setState(() {
          widget.sprinklersOn = false;
          // salvar switch
          roomController.updateSwitches(widget.email, widget.nameId,
              widget.notificationOn, widget.alarmOn, widget.sprinklersOn);
        });
        Navigator.of(context).pop();
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção!", style: GoogleFonts.muli(fontSize: 24)),
      content: Text(
        "Desativar os sprinklers pode ser prejudicial à sua saúde e segurança. \n\nOs sprinklers são projetados para proteger você e sua propriedade de incêndios. Ao desativá-los, você está aumentando o risco de incêndio.\n\nSe você precisar desativar os sprinklers, faça isso manualmente e apenas se estiver seguro.",
        style: GoogleFonts.muli(fontSize: 20),
      ),
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
}
