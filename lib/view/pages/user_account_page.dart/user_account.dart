import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/pages/add_vehicle_page/add_vehicle.dart';
import 'package:tec_me/view/pages/dashboard/newDashboard.dart';
import 'package:tec_me/view/pages/history/history_technician.dart';
import 'package:tec_me/view/widgets/account_options_card.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 3);
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
                child: Text(
                  "Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Inria-sans-Regular",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.05,
              ),
              Container(
                width: w * 0.20,
                height: w * 0.20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKc6EnanoKKj61vCCamKeDwXelxNzUElzIWWDgf75XNEa1-uaHgiSq32hF7bp73Tq9nsY&usqp=CAU"),
                ),
              ),
              SizedBox(
                height: w * 0.05,
              ),
              AccountOptionsCard(
                option_name: "Edit Vehicle Info",
                icon: Icon(Icons.arrow_forward_ios_outlined),
                select_option: () {},
              ),
              AccountOptionsCard(
                option_name: "Change Password",
                icon: Icon(Icons.arrow_forward_ios_outlined),
                select_option: () {},
              ),
              AccountOptionsCard(
                option_name: "Sign Out",
                icon: Icon(Icons.arrow_forward_ios_outlined),
                select_option: () {},
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HistoryTechnician(),
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
              break;
          }
        },
        kIconSize: 30,
        kBottomRadius: 12.0,
      ),
    );
  }
}
