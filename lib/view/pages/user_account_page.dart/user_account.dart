import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/pages/add_vehicle_page/add_vehicle.dart';
import 'package:tec_me/view/pages/dashboard/newDashboard.dart';
import 'package:tec_me/view/pages/history/history_technician.dart';
import 'package:tec_me/view/pages/login/login.dart';
import 'package:tec_me/view/pages/change_password/change_password.dart';
import 'package:tec_me/view/widgets/account_options_card.dart';
import 'package:tec_me/view_model/bloc/user_account_bloc/bloc/user_account_bloc.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  final UserAccountBloc userAccountBloc = UserAccountBloc();

  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 3);

  @override
  void initState() {
    super.initState();

    userAccountBloc.add(
      UserAccountPageInitialEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: SafeArea(
        child: BlocConsumer(
          bloc: userAccountBloc,
          buildWhen: (previous, current) => current is! UserAccountActionState,
          listenWhen: (previous, current) => current is UserAccountActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case UserAccountInitialState:
                return Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: w,
                            height: w * 0.50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/account/cover_account.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Inria-sans-Regular",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            top: w * 0.15,
                            left: w * 0.36,
                            child: Image.network(
                                width: w * 0.30,
                                height: w * 0.30,
                                fit: BoxFit.cover,
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKc6EnanoKKj61vCCamKeDwXelxNzUElzIWWDgf75XNEa1-uaHgiSq32hF7bp73Tq9nsY&usqp=CAU"),

                            /* child: Image.asset(
                              width: w * 0.30,
                              height: w * 0.30,
                              "assets/icons/app_icon/ic_image.png",
                            ),
                            */
                          ),
                          // Positioned(
                          //   top: w * 0.30,
                          //   left: w * 0.40,
                          //   child: Container(
                          //     width: w * 0.20,
                          //     height: w * 0.20,
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(50.0),
                          //       child: Image.network(
                          //           fit: BoxFit.cover,
                          //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKc6EnanoKKj61vCCamKeDwXelxNzUElzIWWDgf75XNEa1-uaHgiSq32hF7bp73Tq9nsY&usqp=CAU"),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Positioned(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: w * 0.05,
                            ),
                            SizedBox(
                              height: w * 0.05,
                            ),
                            AccountOptionsCard(
                              option_name: "Edit Vehicle Info",
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              select_option: () {
                                print("Edit Vehicle Info");
                              },
                            ),
                            AccountOptionsCard(
                              option_name: "Change Password",
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              select_option: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ChangePassword(),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                            ),
                            AccountOptionsCard(
                              option_name: "Sign Out",
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              select_option: () {
                                print("Sign Out");
                                userAccountBloc.add(
                                  SignoutButtonClickedEvent(),
                                );
                              },
                            ),
                          ],
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
            if (state.runtimeType == SignoutState) {
              Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Login(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  (Route<dynamic> route) => false);
            }
          },
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

/*
Positioned(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Account",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Inria-sans-Regular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: w * 0.05,
                            ),
                            SizedBox(
                              height: w * 0.05,
                            ),
                            AccountOptionsCard(
                              option_name: "Edit Vehicle Info",
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              select_option: () {
                                print("Edit Vehicle Info");
                              },
                            ),
                            AccountOptionsCard(
                              option_name: "Change Password",
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              select_option: () {
                                print("Change Password");
                              },
                            ),
                            AccountOptionsCard(
                              option_name: "Sign Out",
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              select_option: () {
                                print("Sign Out");
                                userAccountBloc.add(
                                  SignoutButtonClickedEvent(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
*/