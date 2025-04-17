import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';

class VehicleCard extends StatelessWidget {
  String image;
  String vehicle_name;
  String vehicle_no;
  String color;
  String year;

  VehicleCard(
      {super.key,
      required this.image,
      required this.vehicle_name,
      required this.vehicle_no,
      required this.color,
      required this.year});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: w * 0.75,
          height: w * 0.32,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8.0, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: w * 0.20,
                  height: w * 0.20,
                  child: Image.asset(
                    image,
                  ),
                ),
                SizedBox(
                  width: w * 0.05,
                ),
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: w * 0.35,
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          vehicle_name,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConfig.font_bold_family,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Text(
                      vehicle_no,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConfig.font_bold_family,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      color,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConfig.font_bold_family,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      year,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConfig.font_bold_family,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0, // Adjust this for exact positioning
          right: 2, // Adjust this for exact positioning
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
