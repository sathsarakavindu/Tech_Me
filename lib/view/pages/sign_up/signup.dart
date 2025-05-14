// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tec_me/view/config/app.dart';
// import 'package:tec_me/view/pages/login/login.dart';
// import 'package:tec_me/view_model/bloc/signup_bloc/bloc/signup_bloc.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final SignupBloc signupBloc = SignupBloc();
//   TextEditingController email_controller = TextEditingController();
//   TextEditingController password_controller = TextEditingController();
//   TextEditingController name_controller = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     signupBloc.add(SignupInitialEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Color(0xFF000b58),
//       body: Container(
//         child: BlocConsumer(
//           bloc: signupBloc,
//           buildWhen: (previous, current) => current is! SignupActionState,
//           listenWhen: (previous, current) => current is SignupActionState,
//           builder: (context, state) {
//             switch (state.runtimeType) {
//               case SignupInitialState:
//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: h * 0.12,
//                     ),
//                     Center(
//                       child: Container(
//                         width: h * 0.115,
//                         height: h * 0.115,
//                         margin: EdgeInsets.only(bottom: h * 0.05),
//                         child: Image.asset(
//                           AppConfig.app_icon,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: w,
//                         height: h * 0.71,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(40.0),
//                             topRight: Radius.circular(40.0),
//                           ),
//                         ),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: h * 0.03,
//                               ),
//                               Text(
//                                 "Sign Up",
//                                 style: TextStyle(
//                                     fontSize: 25,
//                                     fontFamily: 'Inria-sans-bold'),
//                               ),
//                               SizedBox(
//                                 height: h * 0.035,
//                               ),
//                               SizedBox(
//                                 width: w * 0.90,
//                                 child: TextFormField(
//                                   controller: name_controller,
//                                   decoration: InputDecoration(
//                                     hintStyle: TextStyle(
//                                         fontFamily:
//                                             AppConfig.font_regular_family),
//                                     filled: true,
//                                     fillColor: const Color(0xFFD9D9D9),
//                                     hintText: "Enter Name",
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12.0)),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: h * 0.035,
//                               ),
//                               SizedBox(
//                                 width: w * 0.90,
//                                 child: TextFormField(
//                                   controller: email_controller,
//                                   decoration: InputDecoration(
//                                     hintStyle: TextStyle(
//                                         fontFamily:
//                                             AppConfig.font_regular_family),
//                                     filled: true,
//                                     fillColor: const Color(0xFFD9D9D9),
//                                     hintText: "Enter Email",
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12.0)),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: h * 0.035,
//                               ),
//                               SizedBox(
//                                 width: w * 0.90,
//                                 child: TextFormField(
//                                   controller: password_controller,
//                                   decoration: InputDecoration(
//                                     hintStyle: TextStyle(
//                                         fontFamily:
//                                             AppConfig.font_regular_family),
//                                     filled: true,
//                                     fillColor: const Color(0xFFD9D9D9),
//                                     hintText: "Enter Password",
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12.0)),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: h * 0.035,
//                               ),
//                               Container(
//                                 width: w * 0.90,
//                                 height: h * 0.07,
//                                 child: ElevatedButton(
//                                   style: ButtonStyle(
//                                     shape: WidgetStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         // Change your radius here
//                                         borderRadius:
//                                             BorderRadius.circular(12.0),
//                                       ),
//                                     ),
//                                     backgroundColor: WidgetStatePropertyAll(
//                                       Color(0xFF000b58),
//                                     ),
//                                   ),
//                                   onPressed: () async {
//                                     signupBloc.add(
//                                       SignupButtonClickedEvent(
//                                         name: name_controller.text.trim(),
//                                         email: email_controller.text.trim(),
//                                         password:
//                                             password_controller.text.trim(),
//                                       ),
//                                     );
//                                   },
//                                   child: Text(
//                                     "Sign Up",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: AppConfig.font_bold_family,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: h * 0.035,
//                               ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Text(
//                                   "Already Have an Account?",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Inria-sans-Regular'),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: h * 0.025,
//                               ),
//                               Text(
//                                 "Or Sign Up with",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Inria-sans-Regular'),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   print("Google account");
//                                 },
//                                 child: SizedBox(
//                                   width: w * 0.20,
//                                   height: w * 0.20,
//                                   child: Container(
//                                     margin: EdgeInsets.only(bottom: h * 0.005),
//                                     child: Image.asset(
//                                       AppConfig.google_icon,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );

//               default:
//                 return SizedBox();
//             }
//           },
//           listener: (context, state) {
//             if (state.runtimeType == SignupSuccessState) {
//               Navigator.push(
//                 context,
//                 PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) =>
//                       Login(),
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) =>
//                           FadeTransition(
//                     opacity: animation,
//                     child: child,
//                   ),
//                 ),
//               );
//             } else if (state.runtimeType == SignupBackToSigninState) {
//               Navigator.of(context).pop();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
// /*
// Column(
//           children: [
//             SizedBox(
//               height: h * 0.12,
//             ),
//             Center(
//               child: Container(
//                 width: h * 0.115,
//                 height: h * 0.115,
//                 margin: EdgeInsets.only(bottom: h * 0.05),
//                 child: Image.asset(
//                   AppConfig.app_icon,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Container(
//                   width: w,
//                   height: h * 0.71,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40.0),
//                       topRight: Radius.circular(40.0),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: h * 0.03,
//                       ),
//                       Text(
//                         "Sign Up",
//                         style: TextStyle(
//                             fontSize: 25, fontFamily: 'Inria-sans-bold'),
//                       ),
//                       SizedBox(
//                         height: h * 0.035,
//                       ),
//                       SizedBox(
//                         width: w * 0.80,
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             hintStyle: TextStyle(
//                                 fontFamily: AppConfig.font_regular_family),
//                             filled: true,
//                             fillColor: const Color(0xFFD9D9D9),
//                             hintText: "Enter Email",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12.0)),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: h * 0.035,
//                       ),
//                       SizedBox(
//                         width: w * 0.80,
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             hintStyle: TextStyle(
//                                 fontFamily: AppConfig.font_regular_family),
//                             filled: true,
//                             fillColor: const Color(0xFFD9D9D9),
//                             hintText: "Enter Password",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12.0)),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: h * 0.035,
//                       ),
//                       Container(
//                         width: w * 0.80,
//                         height: h * 0.07,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             shape: WidgetStateProperty.all(
//                               RoundedRectangleBorder(
//                                 // Change your radius here
//                                 borderRadius: BorderRadius.circular(12.0),
//                               ),
//                             ),
//                             backgroundColor: WidgetStatePropertyAll(
//                               Color(0xFF000b58),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Text(
//                             "Sign Up",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: AppConfig.font_bold_family,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: h * 0.035,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           print("Clicked");
//                           Navigator.of(context).pop();
//                         },
//                         child: Text(
//                           "Already Have an Account?",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Inria-sans-Regular'),
//                         ),
//                       ),
//                       SizedBox(
//                         height: h * 0.025,
//                       ),
//                       Text(
//                         "Or Sign Up with",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Inria-sans-Regular'),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           print("Google account");
//                         },
//                         child: SizedBox(
//                           width: w * 0.20,
//                           height: w * 0.20,
//                           child: Container(
//                             margin: EdgeInsets.only(bottom: h * 0.005),
//                             child: Image.asset(
//                               AppConfig.google_icon,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
// */