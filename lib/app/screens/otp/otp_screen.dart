import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_out_app/app/constants/gasout_constants.dart';
import 'package:gas_out_app/data/repositories/user/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login/new_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {Key? key, required this.email})
      : super(key: key);
  final String? email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final codeController = TextEditingController();
  bool _loading = false;

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    SvgPicture.asset(
                      "assets/images/otp.svg",
                      height: 180,
                      width: 180,
                      color: ConstantColors.primaryColor,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Código de verificação",
                      style: GoogleFonts.muli(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Enviado para ",
                          style: GoogleFonts.muli(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 15.5),
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.email,
                                style: GoogleFonts.muli(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.5))
                          ]),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                      child: Row(
                        children: [
                          Expanded(flex: 1,
                              child: TextField(
                                controller: codeController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 6,
                                style: GoogleFonts.viga(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    letterSpacing: 40
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "______",
                                    counterText: "",
                                    hintStyle: GoogleFonts.viga(
                                      color: Colors.black.withOpacity(0.3),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent))
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    _loading ? Center(
                      child: CircularProgressIndicator(),
                    ) : RichText(text: TextSpan(
                      text: "Não recebeu o código?  ",
                      style: GoogleFonts.muli(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "REENVIAR O CÓDIGO",
                          style: GoogleFonts.muli(
                            color: ConstantColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              setState(() {
                                _loading = true;
                              });

                              String? response =
                                  await userRepository.sendVerificationCode(
                                  widget.email);

                              if (response != null) {
                                setState(() {
                                  _loading = false;
                                });

                                _showSendCodeSuccessAlertDialog(context);
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                _showSendCodeErrorAlertDialog(context);
                              }
                            },
                        )
                      ]
                    )),
                    SizedBox(
                      height: 40,
                    ),
                    Container(padding: EdgeInsets.symmetric(vertical: 10),
                    height: 40,
                    width: screenSize.width * 0.9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ConstantColors.primaryColor,
                    ),
                    child: FlatButton(
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });

                       bool? response =
                            await userRepository.checkIfCodesAreEqual(widget.email, codeController.text);
                        if (response != null) {
                          setState(() {
                            _loading = false;
                          });

                          if(response == true){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPasswordScreen(email: widget.email)),
                            );
                          }  else {
                            _showCodeErrorAlertDialog(context);
                          }
                        } else {
                          setState(() {
                            _loading = false;
                          });
                          _showSendCodeErrorAlertDialog(context);
                        }
                      },
                      child: Text("VERIFICAR e PROSSEGUIR",
                        style: GoogleFonts.muli(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17
                        ),
                      ),
                    ),

                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
  _showCodeErrorAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Erro", style: GoogleFonts.muli(fontSize: 24)),
      content: Text("Código icorreto.",
          style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  _showSendCodeErrorAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Erro", style: GoogleFonts.muli(fontSize: 24)),
      content: Text("O código não foi enviado ou houve erro durante o envio. Por favor, tente enviá-lo novamente.",
          style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showSendCodeSuccessAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("O código foi enviado com sucesso!",
          style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
