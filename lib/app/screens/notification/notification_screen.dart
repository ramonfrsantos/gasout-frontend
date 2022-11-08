import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_out_app/app/constants/gasout_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';
import '../../components/notification/notification_tiles_component.dart';
import '../../stores/controller/notification/notification_controller.dart';

class NotificationScreen extends KFDrawerContent {
  final String? email;

  NotificationScreen({required this.email});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController _notificationController = NotificationController();

  @override
  void initState() {
    super.initState();
    _notificationController.getUserNotifications(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SafeArea(
        child: Center(
          child: Column(
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
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                            size: 30
                        ),
                        onPressed: widget.onMenuPressed,
                      ),
                    ),
                  ),
                  Text(
                    'Notificações',
                    style: GoogleFonts.muli(
                      fontSize: 22,
                      color: ConstantColors.primaryColor,
                      fontWeight: FontWeight.w400,
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
                            size: 30
                        ),
                        onPressed: (){
                          _showLogOutAlertDialog(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Scaffold(
                  body: _buildBaseBody(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBaseBody() {
    if (_notificationController.notificationList == null) {
      return Center(
        child: const CircularProgressIndicator(),
      );
    } else {
      return RefreshIndicator(
        child: ListView(
                padding: EdgeInsets.zero,
                children: _notificationController.notificationList!
                    .map(
                      (notification) => Dismissible(
                    direction: DismissDirection.startToEnd,
                    key: UniqueKey(),
                    child: Card(
                      child: NotificationTiles(
                          title: notification.title, body: notification.message, date: notification.date),
                    ),
                    onDismissed: (direction) {
                      var notificationChosen = notification;
                      _showAlertDialog(context, notificationChosen.id, widget.email);
                    },
                    background: _deleteBgItem()
                  )
                ).toList()),
        onRefresh: _refresh,
      );
    }
  }

  Future<void> _refresh() async {
    await _notificationController.getUserNotifications(widget.email);

    setState(() {
      _notificationController.notificationList;
    });

    return Future.delayed(Duration(
        seconds: 1
    ));
  }

  Widget _deleteBgItem() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  _showAlertDialog(BuildContext context, String? id, String? email) {
    Widget cancelaButton = TextButton(
      child: Text("NÃO", style: GoogleFonts.muli(
          fontSize: 16,
      )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continuaButton = TextButton(
      child: Text("SIM", style: GoogleFonts.muli(
          fontSize: 16,
      )),
      onPressed: () async {
        await _notificationController.deleteNotification(id);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Atenção!", style: GoogleFonts.muli(
          fontSize: 24
      )),
      content: Text("Você deseja realmente excluir essa notificação?", style: GoogleFonts.muli(
          fontSize: 20
      )),
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

}
