import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  String publicURL = '';

  File? _imageFile;
  String? selectedValue; // currently selected value

  final List<String> items = [
    'Car',
    'Van',
    'Bike',
    'Three-wheel',
    'Lorry',
    'Truck'
  ];

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image uploading error is $e");
    }
  }

  Future<void> uploadToSupabase() async {
    try {
      if (_imageFile == null) return;

      if (_imageFile != null) {
        print("Image file isn't null");
        print(_imageFile);
      }

      final supabase = Supabase.instance.client;
      final fileName = basename(_imageFile!.path); // e.g., image.jpg

      final fileBytes = await _imageFile!.readAsBytes();

      final response = await supabase.storage
          .from('images') // your bucket name
          .uploadBinary(
            'vehicle images/$fileName', // path inside the bucket
            fileBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      if (response.isNotEmpty) {
        publicURL =
            supabase.storage.from('images').getPublicUrl('uploads/$fileName');
        print("✅ Uploaded Successfully: $publicURL");
      } else {
        print("❌ Upload failed");
      }
    } catch (e) {
      print("Image add error to supabase: ${e.toString()}");
    }
  }

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
                            onTap: () async {
                              await pickImage();
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
                        // TextFormAdd(
                        //   controller: type_controller,
                        //   field_name: "Type",
                        //   hint_text: "Vehicle Type",
                        // ),
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
                                      if (newValue != null) {
                                        addVehicleBloc.add(
                                          SelectVehicleListClickedEvent(
                                              vehicle_type: newValue),
                                        );
                                      }
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
                            onPressed: () async {
                              await uploadToSupabase();
                              addVehicleBloc.add(
                                AddVehicleButtonClickedEvent(
                                  image_url: publicURL,
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
              } else if (state.runtimeType == SelectedVehicleState) {
                final successState = state as SelectedVehicleState;
                print(successState.type);
                setState(() {
                  selectedValue = successState.type;
                });
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