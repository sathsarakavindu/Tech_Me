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
              height: h * 0.18,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: h * 0.05),
                child: Image.asset(
                  AppConfig.app_icon,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: w,
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
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: h * 0.035,
                    ),
                    SizedBox(
                      width: w * 0.80,
                      child: TextFormField(
                        decoration: InputDecoration(
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
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.035,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
