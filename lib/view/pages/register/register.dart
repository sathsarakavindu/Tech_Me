import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/register_textFormField.dart';
import 'package:tec_me/view_model/bloc/signup_bloc/bloc/signup_bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();
  TextEditingController contact_no_controller = TextEditingController();
  TextEditingController nic_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  height: h * 0.05,
                ),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 25, fontFamily: 'Inria-sans-bold'),
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                RegisterTextformfield(
                  isPassword: false,
                  editingController: name_controller,
                  hint_text: "Enter Name",
                  prefix_icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Name is required';
                    }

                    // Email regex pattern
                    final nameRegex = RegExp('[a-zA-Z]');

                    if (!nameRegex.hasMatch(p0)) {
                      return 'Enter a valid Name';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                RegisterTextformfield(
                  isPassword: false,
                  editingController: email_controller,
                  hint_text: "Enter Email",
                  prefix_icon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Email is required';
                    }

                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                    if (!emailRegex.hasMatch(p0)) {
                      return 'Enter a valid email';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                RegisterTextformfield(
                  editingController: password_controller,
                  hint_text: "Enter Password",
                  prefix_icon: Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                  isPassword: true,
                  validator: (p0) {},
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                RegisterTextformfield(
                  editingController: confirm_password_controller,
                  hint_text: "Confirm Password",
                  prefix_icon: Icon(
                    Icons.verified,
                    color: Colors.black,
                  ),
                  isPassword: true,
                  validator: (p0) {},
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                RegisterTextformfield(
                  editingController: contact_no_controller,
                  hint_text: "Contact No",
                  prefix_icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  isPassword: false,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Contact No is required';
                    }

                    final contact_no_Regex = RegExp(r'^\d{10}$');

                    if (!contact_no_Regex.hasMatch(p0)) {
                      return 'Enter a valid contact No';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                RegisterTextformfield(
                  editingController: nic_controller,
                  hint_text: "Enter NIC",
                  prefix_icon: Icon(
                    Icons.person_pin_rounded,
                    color: Colors.black,
                  ),
                  isPassword: false,
                  validator: (p0) {},
                ),
                SizedBox(
                  height: h * 0.035,
                ),
                RegisterTextformfield(
                  editingController: address_controller,
                  hint_text: "Enter Address",
                  prefix_icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  isPassword: false,
                  validator: (p0) {},
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
                      if (_formKey.currentState!.validate()) {
                        // ✅ Email is valid
                        print('Email is: ${email_controller.text}');
                      }
                    },
                    child: Text(
                      "Register",
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
