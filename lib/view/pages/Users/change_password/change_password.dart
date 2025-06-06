import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view_model/bloc/change_password_bloc/bloc/change_password_bloc.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ChangePasswordBloc changePasswordBloc = ChangePasswordBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changePasswordBloc.add(
      ChangePasswordInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: SingleChildScrollView(
        child: BlocConsumer(
          bloc: changePasswordBloc,
          buildWhen: (previous, current) =>
              current is! ChangePasswordActionState,
          listenWhen: (previous, current) =>
              current is ChangePasswordActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChangePasswordInitialState:
                return Container(
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
                          margin: EdgeInsets.only(bottom: h * 0.08),
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
                                "Change Password",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Inria-sans-bold'),
                              ),
                              SizedBox(
                                height: h * 0.025,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.10,
                                  ),
                                  Text(
                                    "Enter Current Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inria-sans-bold'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              SizedBox(
                                width: w * 0.80,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.visibility_off_outlined),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Colors.black,
                                    ),
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            AppConfig.font_regular_family),
                                    filled: true,
                                    fillColor: const Color(0xFFD1D3DE),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.028,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.10,
                                  ),
                                  Text(
                                    "Enter New Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inria-sans-bold'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              SizedBox(
                                width: w * 0.80,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.visibility_off_outlined),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ),
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            AppConfig.font_regular_family),
                                    filled: true,
                                    fillColor: const Color(0xFFD1D3DE),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.10,
                                  ),
                                  Text(
                                    "Confirm New Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Inria-sans-bold'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              SizedBox(
                                width: w * 0.80,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.verified,
                                      color: Colors.black,
                                    ),
                                    hintStyle: TextStyle(
                                        fontFamily:
                                            AppConfig.font_regular_family),
                                    filled: true,
                                    fillColor: const Color(0xFFD1D3DE),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
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
                                      Color(0xFF000b58),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //     PageRouteBuilder(
                                    //       pageBuilder: (context, animation,
                                    //               secondaryAnimation) =>
                                    //           Login(),
                                    //       transitionsBuilder: (context,
                                    //               animation,
                                    //               secondaryAnimation,
                                    //               child) =>
                                    //           FadeTransition(
                                    //         opacity: animation,
                                    //         child: child,
                                    //       ),
                                    //     ),
                                    //     (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    "Change Password",
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
                );

              default:
                return SizedBox();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
/*
Container(
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
                  margin: EdgeInsets.only(bottom: h * 0.08),
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
                        "Change Password",
                        style: TextStyle(
                            fontSize: 25, fontFamily: 'Inria-sans-bold'),
                      ),
                      SizedBox(
                        height: h * 0.025,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.10,
                          ),
                          Text(
                            "Enter Current Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inria-sans-bold'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w * 0.80,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                                fontFamily: AppConfig.font_regular_family),
                            filled: true,
                            fillColor: const Color(0xFFD1D3DE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.028,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.10,
                          ),
                          Text(
                            "Enter New Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inria-sans-bold'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w * 0.80,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                                fontFamily: AppConfig.font_regular_family),
                            filled: true,
                            fillColor: const Color(0xFFD1D3DE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.10,
                          ),
                          Text(
                            "Confirm New Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inria-sans-bold'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        width: w * 0.80,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.verified,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                                fontFamily: AppConfig.font_regular_family),
                            filled: true,
                            fillColor: const Color(0xFFD1D3DE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
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
                              Color(0xFF000b58),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      Login(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                            "Change Password",
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
*/