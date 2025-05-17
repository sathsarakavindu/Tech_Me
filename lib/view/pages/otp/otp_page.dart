import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/create_new_password_change/create_new_password.dart';
import 'package:tec_me/view_model/bloc/otp_bloc/bloc/otp_bloc.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final OtpBloc otpBloc = OtpBloc();
  TextEditingController otp_controller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpBloc.add(
      OTPInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: BlocConsumer(
        bloc: otpBloc,
        buildWhen: (previous, current) => current is! OTPActionState,
        listenWhen: (previous, current) => current is OTPActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case OTPInitialState:
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: h,
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.12,
                        ),
                        Center(
                          child: Container(
                            width: h * 0.115,
                            height: h * 0.115,
                            margin: EdgeInsets.only(bottom: h * 0.28),
                            child: Image.asset(
                              AppConfig.app_icon,
                            ),
                          ),
                        ),
                        Expanded(
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
                                  "OTP Verification",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Inria-sans-bold'),
                                ),
                                SizedBox(
                                  height: h * 0.010,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: w * 0.10,
                                    ),
                                    SizedBox(
                                      width: w * 0.80,
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "The OTP Code was sent to your registered email",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Inria-sans-bold'),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                SizedBox(
                                  width: w * 0.80,
                                  child: TextFormField(
                                    controller: otp_controller,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontFamily:
                                              AppConfig.font_regular_family),
                                      filled: true,
                                      fillColor: const Color(0xFFD1D3DE),
                                      hintText: "EX: 4526",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter OTP";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.015,
                                ),
                                SizedBox(
                                  width: w * 0.80,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Don't receive the OTP ?",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Inria-sans-bold'),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Resend",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: 'Inria-sans-bold'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                Container(
                                  width: w * 0.80,
                                  height: h * 0.07,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          // Change your radius here
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFF000b58),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        otpBloc.add(
                                          OTPVerifyButtonClickedEvent(
                                              otp_code: otp_controller.text),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Verify & Proceed",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              AppConfig.font_bold_family,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                Container(
                                  width: w * 0.80,
                                  height: h * 0.07,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          // Change your radius here
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFFD1D3DE),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Back",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily:
                                              AppConfig.font_bold_family,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return SizedBox();
          }
        },
        listener: (context, state) {
          if (state is OTPSuccessState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    NewPasswordPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
            );
          } else if (state is OTPErrorState) {
            print("OTPErrorState");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("OTP is invalid!"),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is OTPBackState) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
/*
SingleChildScrollView(
        child: Container(
          height: h,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.12,
              ),
              Center(
                child: Container(
                  width: h * 0.115,
                  height: h * 0.115,
                  margin: EdgeInsets.only(bottom: h * 0.28),
                  child: Image.asset(
                    AppConfig.app_icon,
                  ),
                ),
              ),
              Expanded(
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
                        "OTP Verification",
                        style: TextStyle(
                            fontSize: 25, fontFamily: 'Inria-sans-bold'),
                      ),
                      SizedBox(
                        height: h * 0.010,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.10,
                          ),
                          SizedBox(
                            width: w * 0.80,
                            child: Text(
                              textAlign: TextAlign.center,
                              "The OTP Code was sent to your registered email",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Inria-sans-bold'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w * 0.80,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontFamily: AppConfig.font_regular_family),
                            filled: true,
                            fillColor: const Color(0xFFD1D3DE),
                            hintText: "EX: 4526",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.015,
                      ),
                      SizedBox(
                        width: w * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Don't receive the OTP ?",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Inria-sans-bold'),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                textAlign: TextAlign.center,
                                "Resend",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Inria-sans-bold'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.03,
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        NewPasswordPage(),
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
                            "Verify & Proceed",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppConfig.font_bold_family,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.03,
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
                              Color(0xFFD1D3DE),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppConfig.font_bold_family,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
*/