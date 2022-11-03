import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_out_app/app/constants/gasout_constants.dart';
import 'package:gas_out_app/app/screens/login/forgot_password_screen.dart';
import 'package:gas_out_app/data/repositories/user/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../data/model/login/login_response_model.dart';
import '../../../data/repositories/login/login_repository.dart';
import '../../../main.dart';
import '../../stores/controller/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _pageState = 1;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;
  double _loginXOffset = 0;
  double _loginYOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;
  bool _loading = false;

  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  final emailSignUpController = TextEditingController();
  final passwordSignUpController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool? _confirmPasswordSignUpVisible;
  bool? _passwordSignUpVisible;
  bool? _passwordLoginVisible;

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    emailSignUpController.dispose();
    passwordSignUpController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  UserRepository userRepository = UserRepository();
  LoginController loginController = LoginController();

  @override
  void initState() {
    _passwordLoginVisible = false;
    _passwordSignUpVisible = false;
    _confirmPasswordSignUpVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 190;
    _registerHeight = windowHeight - 190;

    switch (_pageState) {
      case 0:
        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 190;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;

      case 1:
        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 60 : 190;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 190;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;

      case 2:
        _loginWidth = windowWidth - 60;
        _loginOpacity = 0.5;

        _loginYOffset = _keyboardVisible ? 60 : 190;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 160;

        _loginXOffset = 20;
        _registerYOffset = _keyboardVisible ? 60 : 190;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 160;
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
              child: SingleChildScrollView(
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
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: passwordLoginController,
                                    obscureText: !(_passwordLoginVisible!),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.vpn_key),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordLoginVisible!
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: _passwordLoginVisible!
                                                ? Theme.of(context)
                                                    .primaryColorDark
                                                : Colors.grey,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordLoginVisible =
                                                  !(_passwordLoginVisible!);
                                            });
                                          },
                                        ),
                                        hintText: "Senha",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Forget working');
                            emailLoginController.text = "";
                            passwordLoginController.text = "";
                            passwordSignUpController.text = "";
                            confirmPasswordController.text = "";
                            nameController.text = "";
                            emailSignUpController.text = "";
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                          },
                          child: Container(
                            height: 30,
                            child: FadeAnimation(
                                delay: 1.5,
                                child: Text(
                                  "Esqueci minha senha",
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 16),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          delay: 1.6,
                          child: FlatButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });

                              LoginResponseModel? response =
                                  await loginController.doLogin(
                                      emailLoginController.text,
                                      passwordLoginController.text);

                              print(response.toString());

                              if (response?.userId != null) {
                                setState(() {
                                  _loading = false;
                                });

                                emailLoginController.text = "";
                                passwordLoginController.text = "";
                                passwordSignUpController.text = "";
                                confirmPasswordController.text = "";
                                nameController.text = "";
                                emailSignUpController.text = "";

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainWidget(
                                            title: 'GasOut',
                                            username: response?.userName,
                                            email: response?.login,
                                        client: new MqttServerClient('aulwdm3oigmf5-ats.iot.us-east-1.amazonaws.com', ''),
                                        isConnected: false
                                          )),
                                );
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                _showLoginErrorAlertDialog(context);
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
                                        'Entrar',
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
                        GestureDetector(
                          onTap: () {
                            print("sign  up working");
                            setState(() {
                              _pageState = 2;
                            });
                            emailLoginController.text = "";
                            passwordLoginController.text = "";
                          },
                          child: Container(
                            child: FadeAnimation(
                              delay: 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Não possui uma conta? ",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                  Text(
                                    "Cadastre-se",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          // Signup Screen
          AnimatedContainer(
            padding: EdgeInsets.only(bottom: 40, left: 50, right: 50, top: 55),
            height: _registerHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Nome completo",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          height: 0.5),
                                      border: InputBorder.none,
                                      errorText: loginController
                                          .getErrorName(loginController.name)),
                                  onChanged: (value) {
                                    setState(() {
                                      loginController.name = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  controller: emailSignUpController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: "E-mail",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      errorStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          height: 0.5),
                                      border: InputBorder.none,
                                      errorText: loginController
                                          .getErrorEmail(loginController.email)),
                                  onChanged: (value) {
                                    setState(() {
                                      loginController.email = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                    controller: passwordSignUpController,
                                    obscureText: !(_passwordSignUpVisible!),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.vpn_key),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordSignUpVisible!
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: _passwordSignUpVisible!
                                                ? Theme.of(context)
                                                    .primaryColorDark
                                                : Colors.grey,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordSignUpVisible =
                                                  !(_passwordSignUpVisible!);
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
                                  obscureText: !(_confirmPasswordSignUpVisible!),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.vpn_key),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _confirmPasswordSignUpVisible!
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: _confirmPasswordSignUpVisible!
                                              ? Theme.of(context).primaryColorDark
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _confirmPasswordSignUpVisible =
                                                !(_confirmPasswordSignUpVisible!);
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
                                      errorText:
                                          loginController.getErrorConfirmPassword(
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
                        height: 30,
                      ),
                      FadeAnimation(
                        delay: 1.6,
                        child: Observer(
                          builder: (context) {
                            return FlatButton(
                              onPressed: loginController.isSignUpButtonEnabled
                                  ? () async {
                                      setState(() {
                                        _loading = true;
                                      });

                                      int? statusCode =
                                          await userRepository.createUser(
                                              emailSignUpController.text,
                                              nameController.text,
                                              passwordSignUpController.text);

                                      if (statusCode == 200) {
                                        setState(() {
                                          _pageState = 1;
                                          _showSignUpSuccessAlertDialog(context);
                                          emailLoginController.text = "";
                                          passwordLoginController.text = "";
                                          passwordSignUpController.text = "";
                                          confirmPasswordController.text = "";
                                          nameController.text = "";
                                          emailSignUpController.text = "";
                                          _loading = false;
                                        });
                                      } else {
                                        setState(() {
                                          _showSignUpErrorAlertDialog(context);
                                          _loading = false;
                                        });
                                        print(statusCode);
                                      }
                                    }
                                  : null,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: loginController.isSignUpButtonEnabled
                                        ? ConstantColors.primaryColor
                                        : ConstantColors.secondaryColor
                                ),
                                child: Center(
                                  // child: Text(
                                  //   'Cadastrar',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 20),
                                  // ),
                                  child: _loading
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Cadastrar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("sign  up working");
                          setState(() {
                            _pageState = 1;

                            passwordSignUpController.text = "";
                            confirmPasswordController.text = "";
                            nameController.text = "";
                            emailSignUpController.text = "";
                          });
                        },
                        child: Container(
                          child: FadeAnimation(
                            delay: 1.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Já possui uma conta? ",
                                  style: TextStyle(
                                      height: 0.5,
                                      color: Colors.grey,
                                      fontSize: 16),
                                ),
                                Text(
                                  "Entre aqui.",
                                  style: TextStyle(
                                      height: 0.5,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  _showSignUpErrorAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Erro no cadastro", style: GoogleFonts.muli(fontSize: 24)),
      content: Text("Confira seus dados e tente novamente.",
          style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showLoginErrorAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Erro", style: GoogleFonts.muli(fontSize: 24)),
      content: Text("Dados de login incorretos.",
          style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showSignUpSuccessAlertDialog(BuildContext context) {
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      content:
          Text("Usuário cadastrado com sucesso!", style: GoogleFonts.muli(fontSize: 20)),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  const FadeAnimation({Key? key, required this.delay, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<String>()
      ..add("opacity", Tween(begin: 0.0, end: 1.0), Duration(milliseconds: 500))
      ..add("translateY", Tween(begin: -30.0, end: 1.0),
          Duration(milliseconds: 500), Curves.easeOut);
    return PlayAnimation<MultiTweenValues<String>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
          opacity: animation.get("opacity"),
          child: Transform.translate(
              offset: Offset(0, animation.get("translateY")), child: child)),
    );
  }
}
