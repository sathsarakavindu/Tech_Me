import 'dart:async';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/Technicians/technician_history/technician_history.dart';
import 'package:tec_me/view/pages/Users/history/history_user.dart';
import 'package:tec_me/view/pages/Users/user_account_page.dart/user_account.dart';

import 'package:tec_me/view_model/persistence/sharedPreferences.dart';

class DashboardTechnician extends StatefulWidget {
  const DashboardTechnician({super.key});

  @override
  State<DashboardTechnician> createState() => _DashboardTechnicianState();
}

class _DashboardTechnicianState extends State<DashboardTechnician> {
  String? username;
  final PageController _pageController = PageController();
  PersistenceHelper persistenceHelper = PersistenceHelper();
  int _currentPage = 0;
  bool? isUserAccount;
  GoogleMapController? mapController;
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  final NotchBottomBarController _controller_technician =
      NotchBottomBarController(index: 0);
  final List<String> _images = [
    'assets/images/dashboard/repair_image.png',
    'assets/images/dashboard/repair_image2.png',
    'assets/images/dashboard/repair_image3.png',
  ];
  void loadUsername() async {
    username = await persistenceHelper.getName();
    print("Username from SharedPreferences: $username");
  }

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

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;

    // Request permission
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng pos = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = pos;

      _markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: pos,
          infoWindow: InfoWindow(title: "You are here"),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });

    // Move the camera
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pos, zoom: 15),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUser();
    loadUsername();
    _getCurrentLocation();
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

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
              Text(
                "WELCOME",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppConfig.font_bold_family,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Center(
                child: Text(
                  username ?? 'Guest',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppConfig.font_bold_family,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: w * 0.05,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: w * 0.98,
                height: w * 0.50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: [
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            _images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),
                      // Black Gradient Overlay
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4), // Top fade
                              Colors.black.withOpacity(0.6), // Bottom darker
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: w * 0.20,
                        left: w * 0.22,
                        child: Container(
                          width: w * 0.50,
                          height: w * 0.15,
                          alignment: Alignment.center,
                          child: Text(
                            "Get help for your requirement",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppConfig.font_bold_family,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                ),
                height: w * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Container(
                  child: _currentPosition == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                              target: _currentPosition!,
                              zoom: 15.0,
                            ),
                            scrollGesturesEnabled: true,
                            myLocationEnabled: true, // ✅ Shows blue dot
                            myLocationButtonEnabled: true, // ✅ Location button
                            markers: _markers,
                            zoomControlsEnabled: true,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isUserAccount == true
          ? AnimatedNotchBottomBar(
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
                    break;

                  case 1:
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
                _controller.index = value;
                if (kDebugMode) {
                  print("Selected index: $value");
                }
                switch (value) {
                  case 0:
                    break;

                  case 1:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            TechnicianHistory(),
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
