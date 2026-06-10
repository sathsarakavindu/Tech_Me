import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountOptionsCard extends StatefulWidget {
  String option_name;
  Icon icon;
  void Function()? select_option;

  AccountOptionsCard(
      {super.key,
      required this.option_name,
      required this.icon,
      this.select_option});

  @override
  State<AccountOptionsCard> createState() => _AccountOptionsCardState();
}

class _AccountOptionsCardState extends State<AccountOptionsCard> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.select_option,
      child: Container(
        width: w,
        height: w * 0.14,
        margin: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: w * 0.04),
              child: Text(
                widget.option_name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: "Inria-sans-Regular",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: w * 0.04),
              child: widget.icon,
            ),
          ],
        ),
      ),
    );
  }
}
