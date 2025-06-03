import 'dart:async';
import 'dart:ui' as ui;
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tec_me/model/make_help.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/Technicians/technician_history/technician_history.dart';
import 'package:tec_me/view/pages/Users/history/history_user.dart';
import 'package:tec_me/view/pages/Users/user_account_page.dart/user_account.dart';
import 'package:tec_me/view_model/helperClass/make_help.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final GetHelp getHelp = GetHelp();
  int _currentPage = 0;
  bool? isUserAccount;
  GoogleMapController? mapController;
  Timer? _refreshTimer;
  // Keep track of help request markers separately
  Set<Marker> _helpMarkers = {};
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

  void selectedUserInfo(
      {required String name,
      required String vehicle_image,
      required String vehicle_no,
      required String vehicle_model,
      required String contact_no,
      required String address}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.black,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: vehicle_image.isNotEmpty
                            ? Image.network(
                                vehicle_image,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/default_vehicle.png',
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: AppConfig.font_bold_family,
                            //fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        vehicle_no,
                        style: TextStyle(
                            fontFamily: AppConfig.font_bold_family,
                            //fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        vehicle_model,
                        style: TextStyle(
                            fontFamily: AppConfig.font_bold_family,
                            //fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        contact_no,
                        style: TextStyle(
                            fontFamily: AppConfig.font_bold_family,
                            //fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                            fontFamily: AppConfig.font_bold_family,
                            //fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            // Do something with the contact_no here
                            print("Contact Number is: $contact_no");

                            // Optional: Launch phone dialer (requires url_launcher package)
                            launchUrl(Uri.parse("tel:$contact_no"));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.asset(
                                "assets/icons/dashboard_icon/ic_answer.png"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF000b58),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Approve",
                                style: TextStyle(
                                  color: const ui.Color.fromARGB(
                                      255, 233, 232, 232),
                                  fontFamily: AppConfig.font_bold_family,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConfig.font_bold_family,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
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

  // Start periodic refresh every 10 seconds (adjust as needed)
  void _startPeriodicRefresh() {
    _refreshTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _refreshHelpMarkers();
    });
  }

  // Refresh only help markers, not current location
  Future<void> _refreshHelpMarkers() async {
    try {
      List<MakeHelp> users = await getHelp.getMadeHelps();
      Set<Marker> newHelpMarkers = {};

      print("Refreshing help markers. Found ${users.length} active helps");

      for (int i = 0; i < users.length; i++) {
        MakeHelp user = users[i];
        LatLng userPosition = LatLng(user.latitude, user.longitude);

        BitmapDescriptor userIcon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

        if (user.image_link.isNotEmpty) {
          try {
            userIcon = await getCustomMarkerFromNetwork(user.image_link);
          } catch (e) {
            print("Error loading marker icon for ${user.user_name}: $e");
          }
        }

        newHelpMarkers.add(
          Marker(
            markerId:
                MarkerId("help_${user.nic}"), // Use unique ID from database
            position: userPosition,
            infoWindow: InfoWindow(
                // title: user.user_name,
                // snippet: "${user.model} - ${user.vehicle_no}",
                ),
            icon: userIcon,
            onTap: () => selectedUserInfo(
                name: user.user_name,
                address: user.address,
                contact_no: user.contact_no,
                vehicle_no: user.vehicle_no,
                vehicle_image: user.image_link,
                vehicle_model: user.model),
          ),
        );
      }

      setState(() {
        // Remove old help markers
        _markers.removeAll(_helpMarkers);

        // Add new help markers
        _helpMarkers = newHelpMarkers;
        _markers.addAll(_helpMarkers);
      });
    } catch (e) {
      print("Error refreshing help markers: $e");
    }
  }

  Future<BitmapDescriptor> getCustomMarkerFromNetwork(String imageUrl) async {
    final Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();

    final ui.Codec codec =
        await ui.instantiateImageCodec(bytes, targetWidth: 100);
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng pos = LatLng(position.latitude, position.longitude);

    String? imageLink = await persistenceHelper.getSelectedVehicleImage();
    BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

    if (imageLink != null && imageLink.isNotEmpty) {
      try {
        customIcon = await getCustomMarkerFromNetwork(imageLink);
      } catch (e) {
        print("Failed to load current location image icon: $e");
      }
    }

    setState(() {
      _currentPosition = pos;
      _markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: pos,
          infoWindow: InfoWindow(title: "You are here"),
          icon: customIcon,
        ),
      );
    });

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pos, zoom: 15),
      ),
    );
  }

/*  Future<void> _getCurrentLocation() async {
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
*/

  Future<void> manualRefresh() async {
    await _refreshHelpMarkers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserLocations();
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
    // Start periodic refresh for real-time updates
    _startPeriodicRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchUserLocations() async {
    List<MakeHelp> users = await getHelp.getMadeHelps();
    Set<Marker> userMarkers = {};

    print("User list length: ${users.length}");

    for (int i = 0; i < users.length; i++) {
      MakeHelp user = users[i];
      LatLng userPosition = LatLng(user.latitude, user.longitude);

      BitmapDescriptor userIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

      if (user.image_link.isNotEmpty) {
        try {
          userIcon = await getCustomMarkerFromNetwork(user.image_link);
        } catch (e) {
          print("Error loading marker icon for ${user.user_name}: $e");
        }
      }

      print(
          "Adding marker for ${user.user_name} at ${user.latitude}, ${user.longitude}");

      userMarkers.add(
        Marker(
          markerId: MarkerId("help_${user.nic}"), // Use unique ID from database
          position: userPosition,
          infoWindow: InfoWindow(
            title: user.user_name,
            snippet: "${user.model} - ${user.vehicle_no}",
          ),
          icon: userIcon,
        ),
      );
    }

    setState(() {
      _helpMarkers = userMarkers;
      _markers.addAll(userMarkers);
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
