import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/dashboard/dashboard.dart';
import 'package:tec_me/view/pages/dashboard/newDashboard.dart';
import 'package:tec_me/view/pages/forgot_password/forgot_password.dart';
import 'package:tec_me/view/pages/register/register.dart';
import 'package:tec_me/view/pages/sign_up/signup.dart';
import 'package:tec_me/view_model/bloc/bloc/login_bloc.dart';
import 'package:tec_me/view_model/helperClass/loginUser.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  UserAuth userAuth = UserAuth();
  final LoginBloc loginInitialBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    loginInitialBloc.add(
      LoginInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: Container(
          child: BlocConsumer(
        bloc: loginInitialBloc,
        listenWhen: (previous, current) => current is LoginAction,
        buildWhen: (previous, current) => current is! LoginAction,
        builder: (context, state) {
          switch (state.runtimeType) {
            case InitialLoginState:
              return Column(
                children: [
                  SizedBox(
                    height: h * 0.12,
                  ),
                  Center(
                    child: Container(
                      width: h * 0.115,
                      height: h * 0.115,
                      margin: EdgeInsets.only(bottom: h * 0.05),
                      child: Image.asset(
                        AppConfig.app_icon,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: w,
                        height: h * 0.71,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.03,
                            ),
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 25, fontFamily: 'Inria-sans-bold'),
                            ),
                            SizedBox(
                              height: h * 0.035,
                            ),
                            SizedBox(
                              width: w * 0.90,
                              child: TextFormField(
                                controller: email_controller,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily:
                                          AppConfig.font_regular_family),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Email",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.035,
                            ),
                            SizedBox(
                              width: w * 0.90,
                              child: TextFormField(
                                obscureText: true,
                                controller: password_controller,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily:
                                          AppConfig.font_regular_family),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Password",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.035,
                            ),
                            Container(
                              width: w * 0.90,
                              height: h * 0.07,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      // Change your radius here
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color(0xFF000b58),
                                  ),
                                ),
                                onPressed: () async {
                                  loginInitialBloc.add(
                                    LoginButtonClickEvent(
                                        email: email_controller.text,
                                        password: password_controller.text),
                                  );
                                  // await userAuth.signinUser(
                                  //     email_controller.text.trim(),
                                  //     password_controller.text.trim());
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //     pageBuilder:
                                  //         (context, animation, secondaryAnimation) =>
                                  //             DashboardPage(),
                                  //     transitionsBuilder: (context, animation,
                                  //             secondaryAnimation, child) =>
                                  //         FadeTransition(
                                  //       opacity: animation,
                                  //       child: child,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppConfig.font_bold_family,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.035,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Clicked");
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const Register(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Create an Account",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inria-sans-Regular'),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.025,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Forgotten Password");
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const ForgotPassword(),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgotten Password?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inria-sans-Regular'),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.025,
                            ),
                            Text(
                              "Or Sign In with",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inria-sans-Regular'),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Google account");
                              },
                              child: SizedBox(
                                width: w * 0.20,
                                height: w * 0.20,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: h * 0.005),
                                  child: Image.asset(
                                    AppConfig.google_icon,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );

            default:
              return SizedBox();
          }
        },
        listener: (context, state) {
          if (state.runtimeType == LoginSuccessState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DashboardNew(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
            );
          } else if (state.runtimeType == LoginFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Login failed"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      )),
    );
  }
}
