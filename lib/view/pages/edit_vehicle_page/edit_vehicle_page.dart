import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/text_form_field.dart';

class EditVehiclePage extends StatefulWidget {
  const EditVehiclePage({super.key});

  @override
  State<EditVehiclePage> createState() => _EditVehiclePageState();
}

class _EditVehiclePageState extends State<EditVehiclePage> {
  TextEditingController vehicle_no_controller = TextEditingController();
  TextEditingController model_controller = TextEditingController();
  TextEditingController type_controller = TextEditingController();
  TextEditingController color_controller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Edit Vehicle",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppConfig.font_bold_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      print("object");
                    },
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
                    "Update Vehicle Image",
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
                  controller: vehicle_no_controller,
                    hint_text: "EX: WP-CAD - 5617", field_name: "Vehicle No"),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  controller: model_controller,
                    hint_text: "EX: SUZUKI ALTO 2017", field_name: "Model"),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  controller: type_controller,
                  hint_text: "Vehicle Type", field_name: "Type"),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  controller: color_controller,
                  hint_text: "EX: Black", field_name: "Color"),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Color(0xFFC7C7C7),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Save",
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
