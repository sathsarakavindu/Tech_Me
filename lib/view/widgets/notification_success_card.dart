import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';

class NotificationSuccess extends StatelessWidget {
  final String notification_text;
  const NotificationSuccess({super.key, required this.notification_text});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      // width: w * 0.50,
      // height: w * 0.15,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              notification_text,
              style: TextStyle(
                fontFamily: AppConfig.font_bold_family,
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              "assets/images/notification/ic_success.png",
              width: w * 0.06,
              height: w * 0.06,
            )
          ],
        ),
      ),
    );
  }
}
