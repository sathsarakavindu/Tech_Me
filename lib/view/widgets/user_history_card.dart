import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserHistoryCard extends StatelessWidget {
  String service_center_image;
  String service_center_name;
  String vehicle_no;
  String contact_no;
  String service_center_address;
  String service_date;
  String service_time;
  UserHistoryCard({
    super.key,
    required this.service_center_image,
    required this.service_center_name,
    required this.vehicle_no,
    required this.contact_no,
    required this.service_center_address,
    required this.service_date,
    required this.service_time,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: w * 0.70,
        height: w * 0.58,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: w * 0.15,
              height: w * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                    fit: BoxFit.cover,
                    "https://www.shutterstock.com/image-vector/circle-line-simple-design-logo-600nw-2174926871.jpg"),
              ),
            ),
            Text(
              "Tech Solutions (PVT)LTD",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inria-sans-Regular",
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "MARUTI SUZUKI ALTO",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inria-sans-Regular",
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "WP-CAD-5617",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inria-sans-Regular",
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "0764598798",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inria-sans-Regular",
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              width: w * 0.65,
              child: Text(
                textAlign: TextAlign.center,
                maxLines: 2,
                "No 517/B, Meegahawatta, Delgoda.",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Inria-sans-Regular",
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Text(
              "2024/08/12",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inria-sans-Regular",
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "7.20 P.M",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inria-sans-Regular",
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
