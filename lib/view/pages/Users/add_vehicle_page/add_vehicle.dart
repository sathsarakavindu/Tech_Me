import 'dart:io';
import 'dart:math';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/Users/dashboard/newDashboard.dart';
import 'package:tec_me/view/pages/Users/history/history_user.dart';
import 'package:tec_me/view/pages/Users/user_account_page.dart/user_account.dart';
import 'package:tec_me/view/widgets/text_form_field.dart';
import 'package:tec_me/view_model/bloc/addVehicleBloc/bloc/add_vehicle_bloc.dart';
import 'package:tec_me/view_model/persistence/sharedPreferences.dart';

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
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);
  final AddVehicleBloc addVehicleBloc = AddVehicleBloc();
  String publicURL = '';
  PersistenceHelper persistenceHelper = PersistenceHelper();

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

  String generateRandomNumber() {
    final random = Random();

    // Choose whether to generate 2-digit or 3-digit number
    int length = random.nextBool() ? 2 : 3;

    int min = length == 2 ? 10 : 100;
    int max = length == 2 ? 99 : 999;

    int number = min + random.nextInt(max - min + 1);

    return number.toString();
  }

  Future<void> uploadToSupabase() async {
    try {
      if (_imageFile == null) return;

      print("Image file isn't null");
      print(_imageFile);

      final supabase = Supabase.instance.client;
      final fileName = basename(_imageFile!.path); // e.g., image.jpg
      final fileBytes = await _imageFile!.readAsBytes();

      // Upload to the correct folder in the bucket
      final filePath = 'vehicle images/$fileName';

      final response = await supabase.storage
          .from('images') // bucket name
          .uploadBinary(
            filePath, // correct path in bucket
            fileBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      if (response.isNotEmpty) {
        // ✅ Use the exact same path used in upload
        publicURL = supabase.storage.from('images').getPublicUrl(filePath);
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
      backgroundColor: Color(0xFF000b58),
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
                                color: Colors.white),
                          ),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              await pickImage();
                            },
                            child: Image.asset(
                              "assets/images/add_vehicle/img_add_vehicle.png",
                              color: Colors.white,
                              width: w * 0.30,
                              height: w * 0.26,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Upload Image",
                            style: TextStyle(
                              color: Colors.white,
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
                          prefix_icon: Icon(Icons.numbers, color: Colors.white),
                          controller: vehicle_no_controller,
                          field_name: "Vehicle No",
                          hint_text: "EX: WP-CAD-5617",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormAdd(
                          prefix_icon:
                              Icon(Icons.model_training, color: Colors.white),
                          controller: model_controller,
                          field_name: "Model",
                          hint_text: "EX: SUZUKI ALTO 2017",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Type",
                                  style: TextStyle(
                                    color: Colors.white,
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
                                    color: Colors.white,
                                  ),
                                ),
                                width: w,
                                height: w *
                                    0.15, // ⬆️ Increase this to make the dropdown taller
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.white,
                                    ),
                                    isExpanded: true,
                                    iconSize:
                                        28, // ⬆️ Optional: increase dropdown icon size
                                    borderRadius: BorderRadius.circular(12.0),
                                    hint: Center(
                                      child: Text(
                                        "Select Vehicle",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
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
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
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
                          prefix_icon:
                              Icon(Icons.color_lens, color: Colors.white),
                          controller: color_controller,
                          field_name: "Color",
                          hint_text: "EX: Black",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            width: w * 0.95,
                            height: w * 0.14,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                await uploadToSupabase();
                                addVehicleBloc.add(
                                  AddVehicleButtonClickedEvent(
                                    contact_no:
                                        await persistenceHelper.getContactNo(),
                                    email: await persistenceHelper.getEmail(),
                                    name: await persistenceHelper.getName(),
                                    nic: await persistenceHelper.getNIC(),
                                    image_url: publicURL,
                                    vehicle_no:
                                        vehicle_no_controller.text.trim(),
                                    model: model_controller.text.trim(),
                                    type: selectedValue!,
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
      bottomNavigationBar: AnimatedNotchBottomBar(
        durationInMilliSeconds: 500,
        notchBottomBarController: _controller,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.black,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.black,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Image.asset(
              "assets/images/add_vehicle/add_vehicle.png",
              color: Colors.black,
            ),
            activeItem: Image.asset("assets/images/add_vehicle/add_vehicle.png",
                color: Colors.black),
            itemLabel: 'Vehicle',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.history,
              color: Colors.black,
            ),
            activeItem: Icon(
              Icons.history,
              color: Colors.black,
            ),
            itemLabel: 'History',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.person,
              color: Colors.black,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.black,
            ),
            itemLabel: 'Account',
          ),
        ],
        onTap: (value) {
          _controller.index = value;
          if (kDebugMode) {
            print("Selected index: $value");
          }
          switch (value) {
            case 0:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DashboardNew(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HistoryUser(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UserAccountPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
              break;
          }
        },
        kIconSize: 30,
        kBottomRadius: 12.0,
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