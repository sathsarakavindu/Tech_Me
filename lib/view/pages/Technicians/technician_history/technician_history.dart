import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/pages/Technicians/technician_dashboard/dashboard_technician.dart';
import 'package:tec_me/view/pages/Users/user_account_page.dart/user_account.dart';
import 'package:tec_me/view/widgets/user_history_card.dart';
import 'package:tec_me/view_model/persistence/sharedPreferences.dart';

class TechnicianHistory extends StatefulWidget {
  const TechnicianHistory({super.key});

  @override
  State<TechnicianHistory> createState() => _TechnicianHistoryState();
}

class _TechnicianHistoryState extends State<TechnicianHistory> {
  final NotchBottomBarController _controller_technician =
      NotchBottomBarController(index: 1);
  final PersistenceHelper persistenceHelper = PersistenceHelper();
  bool? isUserAccount;
  Future<void> isUser() async {
    try {
      if (await persistenceHelper.getAccountType() == "User")
        setState(() {
          isUserAccount = true;
        });
      else
        setState(() {
          isUserAccount = false;
        });
    } catch (e) {
      print("isUser error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUser();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserHistoryCard(
                service_center_image:
                    "https://www.shutterstock.com/image-vector/circle-line-simple-design-logo-600nw-2174926871.jpg",
                service_center_name: "User Name",
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
      bottomNavigationBar: isUserAccount == true
          ? AnimatedNotchBottomBar(
              durationInMilliSeconds: 500,
              notchBottomBarController: _controller_technician,
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
                  activeItem: Image.asset(
                      "assets/images/add_vehicle/add_vehicle.png",
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
                _controller_technician.index = value;
                if (kDebugMode) {
                  print("Selected index: $value");
                }
                switch (value) {
                  case 0:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DashboardTechnician(),
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
            )
          : AnimatedNotchBottomBar(
              durationInMilliSeconds: 500,
              notchBottomBarController: _controller_technician,
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
                _controller_technician.index = value;
                if (kDebugMode) {
                  print("Selected index: $value");
                }
                switch (value) {
                  case 0:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DashboardTechnician(),
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
