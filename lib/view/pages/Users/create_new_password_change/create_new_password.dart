import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/Users/login/login.dart';

import 'package:tec_me/view_model/bloc/create_new_password_bloc/bloc/create_new_password_bloc.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final CreateNewPasswordBloc createNewPasswordBloc = CreateNewPasswordBloc();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reEnterPasswordController = TextEditingController();
  bool is_hide_password = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createNewPasswordBloc.add(
      CreateNewPasswordInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFF000b58),
        body: BlocConsumer(
          bloc: createNewPasswordBloc,
          buildWhen: (previous, current) =>
              current is! CreateNewPasswordActionState,
          listenWhen: (previous, current) =>
              current is CreateNewPasswordActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case CreateNewPasswordInitialState:
                return Container(
                  height: h,
                  child: Form(
                    key: _fromKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.12,
                        ),
                        Center(
                          child: Container(
                            width: h * 0.115,
                            height: h * 0.11,
                            margin: EdgeInsets.only(bottom: h * 0.15),
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
                                  "Create New Password",
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
                                      "Enter Your New Password",
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
                                    controller: _newPasswordController,
                                    obscureText: is_hide_password,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            is_hide_password =
                                                !is_hide_password;
                                          });
                                        },
                                        icon: is_hide_password == true
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
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
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password field is empty";
                                      }
                                      null;
                                    },
                                  ),
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
                                      "Re-Enter Password",
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
                                    controller: _reEnterPasswordController,
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Re-enter password is empty.";
                                      }
                                      if (_newPasswordController.text !=
                                          _reEnterPasswordController.text) {
                                        return "Password do not match";
                                      }
                                      null;
                                    },
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
                                      if (_fromKey.currentState!.validate()) {
                                        createNewPasswordBloc.add(
                                          CreatePasswordButtonClickedEvent(
                                              new_password:
                                                  _newPasswordController.text),
                                        );
                                        print(
                                            "change password: ${_newPasswordController.text}");
                                      }
                                    },
                                    child: Text(
                                      "Change Password",
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
                );

              default:
                return SizedBox();
            }
          },
          listener: (context, state) {
            if (state is CreateNewPasswordSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Login(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  (Route<dynamic> route) => false);
            } else if (state is CreateNewPasswordErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Password can't be changed."),
                ),
              );
            } else if (state is CreateNewPasswordBackState) {
              Navigator.of(context).pop();
            }
          },
        ));
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
                margin: EdgeInsets.only(bottom: h * 0.20),
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
                      "Create New Password",
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
                          "Enter Your New Password",
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
                      height: h * 0.025,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: w * 0.10,
                        ),
                        Text(
                          "Re-Enter Password",
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
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