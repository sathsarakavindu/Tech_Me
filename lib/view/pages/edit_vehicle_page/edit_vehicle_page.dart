import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/text_form_field.dart';
import 'package:tec_me/view_model/bloc/editVehicleBloc/bloc/edit_vehicle_bloc.dart';

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

  final EditVehicleBloc editVehicleBloc = EditVehicleBloc();
  String? selectedValue; // currently selected value

  final List<String> items = [
    'Car',
    'Van',
    'Bike',
    'Three-wheel',
    'Lorry',
    'Truck'
  ];

  @override
  void initState() {
    super.initState();
    editVehicleBloc.add(
      EditVehicleInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer(
          bloc: editVehicleBloc,
          listenWhen: (previous, current) => current is EditVehicleActionState,
          buildWhen: (previous, current) => current is! EditVehicleActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case EditVehicleInitialState:
                return SingleChildScrollView(
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
                            hint_text: "EX: WP-CAD - 5617",
                            field_name: "Vehicle No"),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormAdd(
                            controller: model_controller,
                            hint_text: "EX: SUZUKI ALTO 2017",
                            field_name: "Model"),
                        SizedBox(
                          height: 20,
                        ),
                        // TextFormAdd(
                        //     controller: type_controller,
                        //     hint_text: "Vehicle Type",
                        //     field_name: "Type"),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Type",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppConfig.font_bold_family,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                width: w,
                                height: w *
                                    0.15, // ⬆️ Increase this to make the dropdown taller
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    iconSize:
                                        28, // ⬆️ Optional: increase dropdown icon size
                                    borderRadius: BorderRadius.circular(12.0),
                                    hint: Text("Select Vehicle",
                                        style: TextStyle(fontSize: 16)),
                                    value: selectedValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue;
                                      });
                                    },
                                    items: items.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  12.0), // ⬆️ Increases item height
                                          child: Text(item,
                                              style: TextStyle(fontSize: 16)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormAdd(
                            controller: color_controller,
                            hint_text: "EX: Black",
                            field_name: "Color"),
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
                );

              default:
                return SizedBox();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
/*
SingleChildScrollView(
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
*/