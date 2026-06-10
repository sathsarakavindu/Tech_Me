import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/pages/Users/add_vehicle_page/add_vehicle.dart';
import 'package:tec_me/view/pages/Users/dashboard/newDashboard.dart';
import 'package:tec_me/view/pages/Users/user_account_page.dart/user_account.dart';
import 'package:tec_me/view/widgets/user_history_card.dart';
import 'package:tec_me/view_model/bloc/user_history_bloc/bloc/user_history_bloc.dart';

class HistoryUser extends StatefulWidget {
  const HistoryUser({super.key});

  @override
  State<HistoryUser> createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 2);

  final UserHistoryBloc userHistoryBloc = UserHistoryBloc();

  @override
  void initState() {
    super.initState();
    userHistoryBloc.add(
      UserHistoryCardInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserHistoryCard(
                service_center_image:
                    "https://www.shutterstock.com/image-vector/circle-line-simple-design-logo-600nw-2174926871.jpg",
                service_center_name: "Tech Solutions (PVT)LTD",
                vehicle_no: "WP-CAD-5617",
                contact_no: "0764598798",
                service_center_address: "No 517/B, Meegahawatta, Delgoda.",
                service_date: "2024/08/12",
                service_time: "7.20 P.M",
              ),
            ],
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
