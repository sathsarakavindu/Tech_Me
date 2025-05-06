import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';

class RegisterTextformfield extends StatefulWidget {
  Icon prefix_icon;
  TextEditingController editingController;
  String hint_text;
  bool isPassword;
  Function(String?) validator;
  RegisterTextformfield(
      {super.key,
      required this.editingController,
      required this.hint_text,
      required this.prefix_icon,
      required this.isPassword,
      required this.validator});

  @override
  State<RegisterTextformfield> createState() => _RegisterTextformfieldState();
}

class _RegisterTextformfieldState extends State<RegisterTextformfield> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SizedBox(
        width: w * 0.90,
        child: TextFormField(
          obscureText: widget.isPassword,
          controller: widget.editingController,
          validator: (value) => widget.validator!(value),
          decoration: InputDecoration(
            prefixIcon: widget.prefix_icon,
            labelStyle: TextStyle(
              fontFamily: AppConfig.font_regular_family,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12.0),
            ),
            labelText: widget.hint_text,
            
          ),
        )

        );
  }
}
