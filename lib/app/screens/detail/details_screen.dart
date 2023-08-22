import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_out_app/data/model/room/room_response_model.dart';
import 'package:gas_out_app/data/repositories/notification/notification_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/gasout_constants.dart';
import '../../helpers/global.dart';
import '../../stores/controller/notification/notification_controller.dart';

class DetailsScreen extends StatefulWidget {
  final imgPath;
  int averageValue;
  final int maxValue;
  late int totalHours;
  final String? email;
  final String? roomName;

  DetailsScreen(
      {Key? key,
      this.imgPath,
      required this.averageValue,
      required this.maxValue,
      required this.totalHours,
      required this.email,
      required this.roomName})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool alarmValue = false;
  bool notificationValue = false;
  bool sprinklersValue = false;

  @override
  void initState() {
    // COLOCA O VALOR DO SENSOR QUE RETORNA DA API NA VARIÁVEL
    if (roomController.roomList!.isNotEmpty) {
      widget.averageValue = roomController.roomList![0].sensorValue;
    }

    print("Nível de vazamento diario: " + widget.averageValue.toString());

    // SETA O VALOR DOS BOOLEANOS DOS SWITCHES
    setValues();

    super.initState();
  }

  setValues() {
    setState(() {
      widget.averageValue > 0
          ? notificationValue = true
          : notificationValue = false;

      widget.averageValue > 25 ? alarmValue = true : alarmValue = false;

      if (widget.averageValue <= 50) {
        roomController.sprinklersValue = false;
      } else {
        roomController.sprinklersValue = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var valorMedioDiarioPorCento = ((100 * widget.averageValue) / 100);
    return Observer(builder: (context) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height - 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.imgPath), fit: BoxFit.cover)),
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
                  height: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: new Column(
                      children: <Widget>[
                        SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _listItemStats(
                              imgpath: 'assets/images/notification.png',
                              name: "Notificações",
                              value: notificationValue,
                              onChanged: (value) {
                                notificationValue = value;
                              },
                            ),
                            _listItemStats(
                              imgpath: 'assets/images/siren.png',
                              name: "Alarme",
                              value: alarmValue,
                              onChanged: (value) {
                                alarmValue = value;
                              },
                            ),
                            _listItemStats(
                              imgpath: 'assets/images/sprinkler.png',
                              name: "Sprinklers",
                              value: roomController.sprinklersValue,
                              onChanged: (value) {
                                // VERIFICA SE OS SPRINKLERS ESTÃO OU NÃO ATIVOS
                                if (valorMedioDiarioPorCento >= 51) {
                                  roomController.sprinklersValue == true
                                      ? _showAlertDialog(context)
                                      : setState(() {
                                          roomController.sprinklersValue =
                                              value;
                                        });
                                } else {
                                  roomController.sprinklersValue = false;
                                }
                              },
                            ),
                          ],
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Divider(
                              color: Colors.black26,
                            )),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Total de horas monitoradas",
                                style: new TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                widget.totalHours.toString(),
                                style: new TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Nível de vazamento diário",
                                style: new TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                              Spacer(),
                              Text(
                                valorMedioDiarioPorCento.toString() + "%",
                                style: new TextStyle(
                                    color: Colors.black87, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 20, right: 20),
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
        ),
      );
    });
  }

  Widget _monitoring() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 24),
      child: Column(
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
                onChanged: (value){
                  setState(() {
                    monitoringController.setValue(value);
                    widget.totalHours = monitoringController.monitoringTotalHours;
                  });
                },
                activeColor: ConstantColors.primaryColor,
              ),
            ],
          ),
          Text(
            '* Reinicia a contagem de horas totais de monitoramento.',
            style: TextStyle(fontSize: 12, color: Colors.black38),
            textAlign: TextAlign.left,
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
        // SE NÃO CONFIRMA, SPRINKLERS DESLIGADOS
        setState(() {
          roomController.sprinklersValue = true;
        });
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Continuar", style: GoogleFonts.muli(fontSize: 16)),
      onPressed: () {
        // SE CONFIRMA, SPRINKLERS LIGADOS
        setState(() {
          roomController.sprinklersValue = false;
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
