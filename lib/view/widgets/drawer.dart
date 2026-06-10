import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/Users/add_vehicle_page/add_vehicle.dart';
import 'package:tec_me/view/widgets/vehicle_card.dart';
import 'package:tec_me/view_model/persistence/sharedPreferences.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  void _openBottomSheetCalender() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        context: context,
        backgroundColor: Color(0XFFEDECE5),
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.95,
            minChildSize: 0.4,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "History",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConfig.font_bold_family,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: width * 0.10,
                    ),
                    VehicleCard(
                      image: "assets/images/add_vehicle/car1.png",
                      vehicle_name: "MARUTI SUZUKI ALTO",
                      vehicle_no: "WP-CAD-5617",
                      color: "GREY",
                      year: "2017",
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print("Screen height $h");
    print("Screen width $w");
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 20,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            margin: EdgeInsets.only(
              left: 2,
              right: 2,
            ),
            child: SizedBox(
              height: h > 790 ? 290 : 230,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFD8D8D8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Good Morning!",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppConfig.font_bold_family,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      child: Image.asset(
                          width: w * 0.2,
                          height: w * 0.2,
                          "assets/images/drawer/ic_default_user.png"),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      "Roshan Rivishanka",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: AppConfig.font_bold_family,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      "roshanrivishanka99@gmail.com",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: AppConfig.font_bold_family,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  tileColor: Color(0xFFD8D8D8),
                  onTap: () {},
                  title: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: AppConfig.font_bold_family,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  tileColor: Color(0xFFD8D8D8),
                  onTap: () {
                    _openBottomSheetCalender();
                  },
                  title: Text(
                    "History",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: AppConfig.font_bold_family,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  tileColor: Color(0xFFD8D8D8),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (context, animation, secondaryAnimation) =>
                    //         AddVehicle(),
                    //     transitionsBuilder:
                    //         (context, animation, secondaryAnimation, child) =>
                    //             FadeTransition(
                    //       opacity: animation,
                    //       child: child,
                    //     ),
                    //   ),
                    // );
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            AddVehicle(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                    );
                  },
                  title: Text(
                    "Add Vehicle",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: AppConfig.font_bold_family,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  trailing: Icon(Icons.logout),
                  tileColor: Color(0xFFD8D8D8),
                  onTap: () {},
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: AppConfig.font_bold_family,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
