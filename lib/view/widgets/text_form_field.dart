import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';

class TextFormAdd extends StatelessWidget {
  String hint_text;
  String field_name;
  Icon? prefix_icon;
  Color? icon_color;
  TextEditingController controller = TextEditingController();
  TextFormAdd(
      {super.key,
      this.prefix_icon,
      this.icon_color,
      required this.hint_text,
      required this.field_name,
      required this.controller});

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
                  color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: prefix_icon,
                hintText: hint_text,
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
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
