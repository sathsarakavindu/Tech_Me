import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';

class TextFormAdd extends StatelessWidget {
  String hint_text;
  String field_name;
  TextEditingController controller = TextEditingController();
  TextFormAdd({super.key, required this.hint_text, required this.field_name, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              field_name,
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppConfig.font_bold_family,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint_text,
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
