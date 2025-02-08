import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: Container(
        child: Column(
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
                        width: w * 0.80,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontFamily: AppConfig.font_regular_family),
                            filled: true,
                            fillColor: const Color(0xFFD9D9D9),
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.035,
                      ),
                      SizedBox(
                        width: w * 0.80,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontFamily: AppConfig.font_regular_family),
                            filled: true,
                            fillColor: const Color(0xFFD9D9D9),
                            hintText: "Enter Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.035,
                      ),
                      Container(
                        width: w * 0.80,
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
                          onPressed: () {},
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
                        },
                        child: Text(
                          "Already Have an Account?",
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
        ),
      ),
    );
  }
}
