import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/pages/add_vehicle_page/add_vehicle.dart';
import 'package:tec_me/view/pages/dashboard/newDashboard.dart';

class HistoryTechnician extends StatefulWidget {
  const HistoryTechnician({super.key});

  @override
  State<HistoryTechnician> createState() => _HistoryTechnicianState();
}

class _HistoryTechnicianState extends State<HistoryTechnician> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 2);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
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
                      "Vehicle Service: 2023-10-10",
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
            ),
          ],
        ),
      )),
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
              break;
            case 2:
              break;
            case 3:
              break;
          }
        },
        kIconSize: 30,
        kBottomRadius: 12.0,
      ),
    );
  }
}
