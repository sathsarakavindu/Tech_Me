import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/otp/otp_page.dart';
import 'package:tec_me/view/pages/sign_up/signup.dart';
import 'package:tec_me/view_model/bloc/forgot_password_bloc/bloc/forgot_password_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgotPasswordBloc forgotPasswordBloc = ForgotPasswordBloc();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forgotPasswordBloc.add(
      ForgotPasswordPageInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: BlocConsumer(
        listenWhen: (previous, current) => current is ForgotPasswordActionState,
        buildWhen: (previous, current) => current is! ForgotPasswordActionState,
        bloc: forgotPasswordBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ForgotPasswordInitialState:
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
                                  "Forgot Password",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Inria-sans-bold'),
                                ),
                                SizedBox(
                                  height: h * 0.035,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: w * 0.10,
                                    ),
                                    Text("Enter Your Registered Email"),
                                  ],
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                SizedBox(
                                  width: w * 0.80,
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          fontFamily:
                                              AppConfig.font_regular_family),
                                      filled: true,
                                      fillColor: const Color(0xFFD1D3DE),
                                      hintText: "EX: index@example.com",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                    ),
                                    validator: (value) {
                                      
                                      if(value == null || value.isEmpty){
                  return "Email is required.";
                                      }
                                      final emailRegex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  
                                      if(!emailRegex.hasMatch(value)){
                                          return "Enter a valid email";
                                      }
                                      return null;
                                    },
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
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFF000b58),
                                      ),
                                    ),
                                    onPressed: () {

                                         if(_formKey.currentState!.validate()){
forgotPasswordBloc.add(ForgotPasswordContinueButtonClickedEvent(registered_email: _emailController.text),);
                                         }

                                      
                                      // Navigator.push(
                                      //   context,
                                      //   PageRouteBuilder(
                                      //     pageBuilder: (context, animation,
                                      //             secondaryAnimation) =>
                                      //         OtpPage(),
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
                                      "Continue",
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
              );

            default:
              return SizedBox();
          }
        },
        listener: (context, state) {

                 if(state is ForgotPasswordRegisteredEmailSuccessState){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation,
                              secondaryAnimation) =>
                          OtpPage(),
                      transitionsBuilder: (context, animation,
                              secondaryAnimation, child) =>
                          FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ),
                  );

                 }
                 else if(state is ForgotPasswordRegisteredEmailErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Email isn't a registered."),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                 }
                 else if(state is ForgotPasswordBackState){
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
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 25, fontFamily: 'Inria-sans-bold'),
                      ),
                      SizedBox(
                        height: h * 0.035,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.10,
                          ),
                          Text("Enter Your Registered Email"),
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
                            hintText: "EX: index@example.com",
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        OtpPage(),
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
                            "Continue",
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