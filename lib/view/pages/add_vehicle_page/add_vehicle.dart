import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/text_form_field.dart';
import 'package:tec_me/view_model/bloc/addVehicleBloc/bloc/add_vehicle_bloc.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  TextEditingController vehicle_no_controller = TextEditingController();
  TextEditingController model_controller = TextEditingController();
  TextEditingController type_controller = TextEditingController();
  TextEditingController color_controller = TextEditingController();

  final AddVehicleBloc addVehicleBloc = AddVehicleBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addVehicleBloc.add(
      AddVehicleInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: BlocConsumer(
            bloc: addVehicleBloc,
            listenWhen: (previous, current) => current is AddVehicleActionState,
            buildWhen: (previous, current) => current is! AddVehicleActionState,
            builder: (context, state) {
              switch (state.runtimeType) {
                case AddVehicleInitialState:
                  return SingleChildScrollView(
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
                          controller: vehicle_no_controller,
                          field_name: "Vehicle No",
                          hint_text: "EX: WP-CAD-5617",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormAdd(
                          controller: model_controller,
                          field_name: "Model",
                          hint_text: "EX: SUZUKI ALTO 2017",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormAdd(
                          controller: type_controller,
                          field_name: "Type",
                          hint_text: "Vehicle Type",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormAdd(
                          controller: color_controller,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                backgroundColor: Color(0xFFC7C7C7)),
                            onPressed: () {
                              addVehicleBloc.add(
                                AddVehicleButtonClickedEvent(
                                  vehicle_no: vehicle_no_controller.text.trim(),
                                  model: model_controller.text.trim(),
                                  type: type_controller.text.trim(),
                                  color: color_controller.text.trim(),
                                ),
                              );
                            },
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
                  );

                default:
                  return SizedBox();
              }
            },
            listener: (context, state) {
              if (state.runtimeType == AddVehicleSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Vehicle Added Successfully"),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pop(context);
              } else if (state.runtimeType == AddVehicleErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed to add vehicle"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
/*
SingleChildScrollView(
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
                  controller: vehicle_no_controller,
                  field_name: "Vehicle No",
                  hint_text: "EX: WP-CAD-5617",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  controller: model_controller,
                  field_name: "Model",
                  hint_text: "EX: SUZUKI ALTO 2017",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  controller: type_controller,
                  field_name: "Type",
                  hint_text: "Vehicle Type",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormAdd(
                  controller: color_controller,
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
                    onPressed: () {
                      print(vehicle_no_controller.text.trim());
                      print(model_controller.text.trim());
                      print(type_controller.text.trim());
                      print(color_controller.text.trim());
                    },
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
*/