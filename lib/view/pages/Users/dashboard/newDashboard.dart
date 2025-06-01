import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tec_me/model/get_vehicles.dart';
import 'package:tec_me/model/make_help.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/pages/Users/add_vehicle_page/add_vehicle.dart';
import 'package:tec_me/view/pages/Users/history/history_user.dart';
import 'package:tec_me/view/pages/Users/user_account_page.dart/user_account.dart';

import 'package:tec_me/view/widgets/vehicle_card.dart';
import 'package:tec_me/view_model/bloc/dashboardBloc/bloc/dashboard_bloc_bloc.dart';
import 'package:tec_me/view_model/helperClass/vehicleApi.dart';
import 'package:tec_me/view_model/persistence/sharedPreferences.dart';

class DashboardNew extends StatefulWidget {
  const DashboardNew({super.key});

  @override
  State<DashboardNew> createState() => _DashboardNewState();
}

class _DashboardNewState extends State<DashboardNew> {
  final PageController _pageController = PageController();
  PersistenceHelper persistenceHelper = PersistenceHelper();

  int _currentPage = 0;
  String? username;
  String? vehicle_image_link;
  bool getHelp = false;
  VehicleAPI vehicleAPI = VehicleAPI();

  final DashboardBlocBloc dashboardBlocBloc = DashboardBlocBloc();
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  final List<String> _images = [
    'assets/images/dashboard/repair_image.png',
    'assets/images/dashboard/repair_image2.png',
    'assets/images/dashboard/repair_image3.png',
  ];

  final preference = PersistenceHelper();

  GoogleMapController? mapController;
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};

  void checkGetHelpStatus() async {
    bool isGetHelp = await persistenceHelper.getHelpStatus();
    if (isGetHelp) {
      setState(() {
        getHelp = true;
      });
      await _getCurrentLocation();
    } else {
      setState(() {
        getHelp = false;
      });
    }
  }

  void _showPopup(BuildContext context, List<GetVehicles> vehicleList) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Your Vehicle',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000b58),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300, // Adjust as needed
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: vehicleList.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicleList[index];

                    return GestureDetector(
                      onTap: () {
                        List<GetVehicles> selectedVehicle = [vehicle];
                        dashboardBlocBloc.add(
                          SelectVehicleFromList(
                              selectedVehicle: selectedVehicle),
                        );
                        Navigator.pop(context); // Close dialog
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              vehicle.image_url,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            vehicle.vehicle_no,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.redAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelHelp(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Do you want to cancel the help request?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000b58),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => dashboardBlocBloc.add(
                      CancelledHelpRequest(),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () => dashboardBlocBloc.add(
                      NotCancelledHelpRequest(),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget hotelShimmer() {
    double w = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: 1, // number of shimmer items
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: w * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/giffs/map_loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: w * 0.9,
                ),
              )),
        );
      },
    );
  }

  Future<BitmapDescriptor> getCustomMarkerFromNetwork(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    final Uint8List bytes = response.bodyBytes;

    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 100, // Adjust size as needed
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
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

    // Get the vehicle image link from persistenceHelper
    String? vehicleImageLink =
        await persistenceHelper.getSelectedVehicleImage();

    BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
    if (vehicleImageLink != null && vehicleImageLink.isNotEmpty) {
      try {
        customIcon = await getCustomMarkerFromNetwork(vehicleImageLink);
      } catch (e) {
        print("Failed to load vehicle image icon: $e");
      }
    }

    setState(() {
      _currentPosition = pos;
      _markers.removeWhere((m) => m.markerId == MarkerId("currentLocation"));
      _markers.add(Marker(
        markerId: MarkerId("currentLocation"),
        position: pos,
        infoWindow: InfoWindow(title: "You are here"),
        icon: customIcon,
        onTap: () => dashboardBlocBloc.add(
          CancelHelpRequestEvent(),
        ),
      ));
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
    super.initState();
    checkGetHelpStatus();
    loadUsername();
    dashboardBlocBloc.add(
      DashboardInitialEvent(),
    );

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void loadUsername() async {
    username = await preference.getName();
    print("Username from SharedPreferences: $username");
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer(
            listenWhen: (previous, current) => current is DashboardActionState,
            buildWhen: (previous, current) => current is! DashboardActionState,
            bloc: dashboardBlocBloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case DashboardInitialState:
                  return Container(
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
                                        Colors.black
                                            .withOpacity(0.4), // Top fade
                                        Colors.black
                                            .withOpacity(0.6), // Bottom darker
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
                        getHelp == false
                            ? Container(
                                //padding: EdgeInsets.all(2),
                                margin: EdgeInsets.only(
                                  top: 15,
                                  left: 10,
                                  right: 10,
                                ),
                                height: w * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: w * 0.9,
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTq3ukBXDz33mhp_itZa9ETKgy1XlAxIbVPw&s"),
                                      ),
                                    ),
                                    Positioned(
                                      top: w * 0.40,
                                      left: w * 0.32,
                                      child: ElevatedButton(
                                        child: Text(
                                          "Get Help",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                AppConfig.font_bold_family,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        onPressed: () async {
                                          dashboardBlocBloc.add(
                                            GetHelpButtonClickedEvent(),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
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
                                          child: Image.asset(
                                            'assets/giffs/map_loading.gif',
                                            fit: BoxFit.cover,
                                            //height: w * 0.15,
                                            width: w * 0.5,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: GoogleMap(
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              mapController = controller;
                                            },
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: _currentPosition!,
                                              zoom: 15.0,
                                            ),
                                            scrollGesturesEnabled: true,
                                            myLocationEnabled: true,
                                            myLocationButtonEnabled: true,
                                            markers: _markers,
                                            zoomControlsEnabled: true,
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
            listener: (context, state) async {
              if (state is VehicleListDisplayState) {
                List<GetVehicles> own_vehicle_list = state.vehicle_list;
                print("own_vehicle_list length is ${own_vehicle_list.length}");
                return _showPopup(context, own_vehicle_list);
              } else if (state is SelectVehicleSuccessfullyState) {
                vehicle_image_link =
                    await persistenceHelper.getSelectedVehicleImage();
                await _getCurrentLocation();
                //Navigator.of(context).pop();
                await persistenceHelper.setHelpStatus(true);
                setState(() async {
                  getHelp = true;
                });
              } else if (state is DisplayCancelHelpRequestState) {
                _showCancelHelp(context);
              } else if (state is CancelHelpRequestSuccessState) {
                Navigator.of(context).pop();
              } else if (state is NotCancelHelpRequestState) {
                Navigator.of(context).pop();
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
