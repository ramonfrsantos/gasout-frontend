import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_out_app/app/screens/otp/otp_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/repositories/login/login_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../constants/gasout_constants.dart';
import '../../stores/controller/login/login_controller.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key, required this.email}) : super(key: key);
  final String? email;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  int _pageState = 0;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;
  double _loginXOffset = 0;
  double _loginYOffset = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;
  bool _loading = false;

  bool? _confirmPasswordVisible;
  bool? _passwordVisible;

  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  UserRepository userRepository = UserRepository();
  LoginRepository loginRepository = LoginRepository();
  LoginController loginController = LoginController();

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    super.initState();
  }

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
                                height: 25,
                                child: FadeAnimation(
                                    delay: 1.5,
                                    child: Text(
                                      "Digite sua nova senha:",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 15),
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
                                    controller: passwordController,
                                    obscureText: !(_passwordVisible!),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.vpn_key),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible!
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: _passwordVisible!
                                                ? Theme.of(context)
                                                .primaryColorDark
                                                : Colors.grey,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                              !(_passwordVisible!);
                                            });
                                          },
                                        ),
                                        hintText: "Senha",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        errorStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 0.5),
                                        border: InputBorder.none,
                                        errorText:
                                        loginController.getErrorPassword(
                                            loginController.password)),
                                    onChanged: (value) {
                                      setState(() {
                                        loginController.password = value;
                                      });
                                    }),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: confirmPasswordController,
                                  obscureText: !(_confirmPasswordVisible!),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.vpn_key),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _confirmPasswordVisible!
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _confirmPasswordVisible!
                                              ? Theme.of(context)
                                                  .primaryColorDark
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _confirmPasswordVisible =
                                                !(_confirmPasswordVisible!);
                                          });
                                        },
                                      ),
                                      hintText: "Confirmar senha",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          height: 0.5),
                                      border: InputBorder.none,
                                      errorText: loginController
                                          .getErrorConfirmPassword(
                                              loginController.password,
                                              loginController.confirmPassword)),
                                  onChanged: (value) {
                                    setState(() {
                                      loginController.confirmPassword = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                        delay: 1.6,
                        child: Observer(builder: (context){
                          return FlatButton(
                            onPressed: loginController.isCreateNewPasswordButtonEnabled
                                ? () async {
                              setState(() {
                                _loading = true;
                              });

                              int? response = await userRepository.refreshPassword(widget.email, passwordController.text);

                              if (response != null) {
                                setState(() {
                                  _loading = false;
                                });

                                if(response == 200){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  _showCreateNewPasswordSuccessAlertDialog(context);
                                }
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                _showCreateNewPasswordErrorAlertDialog(context);
                              }
                            } : null,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: loginController.isCreateNewPasswordButtonEnabled
                                      ? ConstantColors.primaryColor
                                      : ConstantColors.secondaryColor),
                              child: Center(
                                child: _loading
                                    ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : Text(
                                  'Criar senha',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
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

  _showCreateNewPasswordErrorAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      content:
          Text("Erro na criação da nova senha. Tente novamente.", style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showCreateNewPasswordSuccessAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      content:
      Text("A nova senha foi cadastrada com sucesso!", style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
