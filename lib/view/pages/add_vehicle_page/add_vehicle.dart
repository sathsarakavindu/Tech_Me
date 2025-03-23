import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/text_form_field.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Add a vehicle",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppConfig.font_bold_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/images/add_vehicle/img_add_vehicle.png",
                      color: Colors.black,
                      width: w * 0.25,
                      height: w * 0.25,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Upload Image",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppConfig.font_bold_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  field_name: "Vehicle No",
                  hint_text: "EX: WP-CAD-5617",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  field_name: "Model",
                  hint_text: "EX: SUZUKI ALTO 2017",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  field_name: "Type",
                  hint_text: "Vehicle Type",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  field_name: "Color",
                  hint_text: "EX: Black",
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        backgroundColor: Color(0xFFC7C7C7)),
                    onPressed: () {},
                    child: Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppConfig.font_bold_family,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
