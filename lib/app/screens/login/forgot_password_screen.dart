import 'package:flutter/material.dart';
import 'package:gas_out_app/app/screens/otp/otp_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/repositories/login/login_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../constants/gasout_constants.dart';
import '../../stores/controller/login/login_controller.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _pageState = 0;

  final emailLoginController = TextEditingController();

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;
  double _loginXOffset = 0;
  double _loginYOffset = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;
  bool _loading = false;

  void dispose() {
    emailLoginController.dispose();
    super.dispose();
  }

  UserRepository userRepository = UserRepository();
  LoginRepository loginRepository = LoginRepository();
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 190;

    switch (_pageState) {
      case 0:
        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 60 : 190;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 190;

        _loginXOffset = 0;
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedContainer(
            width: double.infinity,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            decoration: BoxDecoration(color: ConstantColors.primaryColor),
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     colors: [Color(0xffd23232), Color(0xffe37f7f)])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      FadeAnimation(
                        delay: 1,
                        child: Image(
                          image: AssetImage('assets/images/logoPequenaBranco.png'),
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          // Login Screen
          AnimatedContainer(
            padding: _keyboardVisible
                ? EdgeInsets.only(bottom: 40, left: 40, right: 40, top: 55)
                : EdgeInsets.only(bottom: 40, left: 50, right: 50, top: 60),
            width: _loginWidth,
            height: _loginHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform:
            Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(
                color: _loginOpacity == 1
                    ? Colors.white
                    : Color.fromRGBO(255, 255, 255, _loginOpacity),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Opacity(
              opacity: _loginOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      FadeAnimation(
                        delay: 1.4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(40, 40, 40, 0.15),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 18,
                                child: FadeAnimation(
                                    delay: 1.5,
                                    child: Text(
                                      "Digite seu e-mail de confirmação:",
                                      style:
                                      TextStyle(color: Colors.black54, fontSize: 15),
                                    )),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: emailLoginController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "E-mail",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                        delay: 1.6,
                        child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            String? response =
                            await userRepository.sendVerificationCode(
                                emailLoginController.text);

                            if (response != null) {
                              setState(() {
                                _loading = false;
                              });
                              String? email = emailLoginController.text;

                              emailLoginController.text = "";

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(email: email,)),
                              );

                            } else {
                               setState(() {
                                 _loading = false;
                               });
                            _showVerificationCodeErrorAlertDialog(context);
                            }
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: ConstantColors.primaryColor),
                            child: Center(
                              child: _loading
                                  ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text(
                                'Enviar código',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Login with social media
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showVerificationCodeErrorAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Erro", style: GoogleFonts.muli(fontSize: 24)),
      content: Text("Erro ao enviar o código. Tente novamente.",
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
