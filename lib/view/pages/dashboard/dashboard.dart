import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Positon ${_determinePosition.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF000b58),
        title: Text(
          "WELCOME",
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppConfig.font_bold_family,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Builder(
          builder: (context) => SafeArea(
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFFF4B7),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: IconButton(
                    icon: Icon(Icons.menu,
                        color: Colors.black), // Set custom icon color
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Open drawer
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: w * 0.98,
                height: h * 0.60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "..Finding Customers..",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: AppConfig.font_bold_family,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/icons/dashboard_icon/ic_find_location.png",
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
