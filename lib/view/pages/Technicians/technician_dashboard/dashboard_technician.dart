// import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:tec_me/model/make_help.dart';
// import 'package:tec_me/view/config/app.dart';
// import 'package:tec_me/view/pages/Technicians/technician_history/technician_history.dart';
// import 'package:tec_me/view/pages/Users/history/history_user.dart';
// import 'package:tec_me/view/pages/Users/user_account_page.dart/user_account.dart';
// import 'package:tec_me/view_model/helperClass/make_help.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'package:tec_me/view_model/persistence/sharedPreferences.dart';

// class DashboardTechnician extends StatefulWidget {
//   const DashboardTechnician({super.key});

//   @override
//   State<DashboardTechnician> createState() => _DashboardTechnicianState();
// }

// class _DashboardTechnicianState extends State<DashboardTechnician> {
//   String? username;
//   final PageController _pageController = PageController();
//   final PersistenceHelper persistenceHelper = PersistenceHelper();
//   final GetHelp getHelp = GetHelp();
//   int _currentPage = 0;
//   bool? isUserAccount;
//   GoogleMapController? mapController;
//   Timer? _refreshTimer;
//   // Keep track of help request markers separately
//   Set<Marker> _helpMarkers = {};
//   LatLng? _currentPosition;
//   final Set<Marker> _markers = {};
//   final NotchBottomBarController _controller =
//       NotchBottomBarController(index: 0);
//   final NotchBottomBarController _controller_technician =
//       NotchBottomBarController(index: 0);
//   final List<String> _images = [
//     'assets/images/dashboard/repair_image.png',
//     'assets/images/dashboard/repair_image2.png',
//     'assets/images/dashboard/repair_image3.png',
//   ];

//   bool? isApprovedHelp;

//   void loadUsername() async {
//     username = await persistenceHelper.getName();
//     print("Username from SharedPreferences: $username");
//   }

//   void checkHelpApprovalStatus() async {
//     isApprovedHelp = await persistenceHelper.getApproveHelp();

//     if (isApprovedHelp == true) {
//       print("Help request is approved");
//     } else {
//       print("Help request is not approved");
//     }
//   }

//   void selectedUserInfo(
//       {required String help_id,
//       required String name,
//       required String vehicle_image,
//       required String vehicle_no,
//       required String vehicle_model,
//       required String contact_no,
//       required String address}) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       context: context,
//       builder: (context) {
//         return DraggableScrollableSheet(
//             expand: false,
//             initialChildSize: 0.6,
//             minChildSize: 0.3,
//             maxChildSize: 0.9,
//             builder: (_, controller) {
//               return SingleChildScrollView(
//                 child: Container(
//                   width: double.infinity,
//                   //padding: EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(12.0),
//                             topRight: Radius.circular(12.0)),
//                         child: vehicle_image.isNotEmpty
//                             ? Image.network(
//                                 vehicle_image,
//                                 width: double.infinity,
//                                 height: 150,
//                                 fit: BoxFit.cover,
//                               )
//                             : Image.asset(
//                                 'assets/images/default_vehicle.png',
//                                 width: double.infinity,
//                                 height: 150,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         name,
//                         style: TextStyle(
//                             fontFamily: AppConfig.font_bold_family,
//                             //fontWeight: FontWeight.w500,
//                             fontSize: 20),
//                       ),
//                       Text(
//                         vehicle_no,
//                         style: TextStyle(
//                             fontFamily: AppConfig.font_bold_family,
//                             //fontWeight: FontWeight.w500,
//                             fontSize: 20),
//                       ),
//                       Text(
//                         vehicle_model,
//                         style: TextStyle(
//                             fontFamily: AppConfig.font_bold_family,
//                             //fontWeight: FontWeight.w500,
//                             fontSize: 20),
//                       ),
//                       Text(
//                         contact_no,
//                         style: TextStyle(
//                             fontFamily: AppConfig.font_bold_family,
//                             //fontWeight: FontWeight.w500,
//                             fontSize: 20),
//                       ),
//                       Text(
//                         address,
//                         style: TextStyle(
//                             fontFamily: AppConfig.font_bold_family,
//                             //fontWeight: FontWeight.w500,
//                             fontSize: 20),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 20),
//                         child: GestureDetector(
//                           onTap: () {
//                             // Do something with the contact_no here
//                             print("Contact Number is: $contact_no");

//                             // Optional: Launch phone dialer (requires url_launcher package)
//                             launchUrl(Uri.parse("tel:$contact_no"));
//                           },
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Image.asset(
//                                 "assets/icons/dashboard_icon/ic_answer.png"),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 40),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             isApprovedHelp == false
//                                 ? ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Color(0xFF000b58),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     onPressed: () async {
//                                       // await getHelp.approveHelpRequest(
//                                       //   await persistenceHelper.getMakeHelpId(),
//                                       // );
//                                       bool isApprovedHelp =
//                                           await getHelp.approveHelpRequest(
//                                         help_id,
//                                       );

//                                       if (isApprovedHelp) {
//                                         await persistenceHelper
//                                             .setApproveHelp(isApprovedHelp);
//                                         checkHelpApprovalStatus();
//                                         print(
//                                             "Help request approved successfully");
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content:
//                                                 Text("Help request approved"),
//                                           ),
//                                         );
//                                       } else {
//                                         await persistenceHelper
//                                             .setApproveHelp(isApprovedHelp);
//                                         print("Failed to approve help request");
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                                 "Failed to approve help request"),
//                                           ),
//                                         );
//                                       }

//                                       Navigator.pop(context);
//                                     },
//                                     child: Text(
//                                       "Approve",
//                                       style: TextStyle(
//                                         color: const ui.Color.fromARGB(
//                                             255, 233, 232, 232),
//                                         fontFamily: AppConfig.font_bold_family,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   )
//                                 : ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.red,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     onPressed: () async {
//                                       bool isCancelledApproval = await getHelp
//                                           .cancelApprovedHelpRequest(
//                                         help_id,
//                                       );

//                                       if (isCancelledApproval) {
//                                         await persistenceHelper
//                                             .setApproveHelp(false);
//                                         checkHelpApprovalStatus();
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                                 "Successfully cancelled the approved request"),
//                                           ),
//                                         );
//                                       }
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text(
//                                       "Not Approve",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: AppConfig.font_bold_family,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               onPressed: () => Navigator.pop(context),
//                               child: Text(
//                                 "Cancel",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: AppConfig.font_bold_family,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             });
//       },
//     );
//   }

//   Future<void> isUser() async {
//     try {
//       if (await persistenceHelper.getAccountType() == "User")
//         setState(() {
//           isUserAccount = true;
//         });
//       else
//         setState(() {
//           isUserAccount = false;
//         });
//     } catch (e) {
//       print("isUser error: $e");
//     }
//   }

//   // Start periodic refresh every 10 seconds (adjust as needed)
//   void _startPeriodicRefresh() {
//     _refreshTimer = Timer.periodic(Duration(seconds: 10), (timer) {
//       _refreshHelpMarkers();
//     });
//   }

//   // Refresh only help markers, not current location
//   Future<void> _refreshHelpMarkers() async {
//     try {
//       List<MakeHelp> users = await getHelp.getMadeHelps();
//       Set<Marker> newHelpMarkers = {};

//       print("Refreshing help markers. Found ${users.length} active helps");

//       for (int i = 0; i < users.length; i++) {
//         MakeHelp user = users[i];
//         LatLng userPosition = LatLng(user.latitude, user.longitude);

//         BitmapDescriptor userIcon =
//             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

//         if (user.image_link.isNotEmpty) {
//           try {
//             print("Help id: ${user.help_id}");
//             userIcon = await getCustomMarkerFromNetwork(user.image_link);
//           } catch (e) {
//             print("Error loading marker icon for ${user.user_name}: $e");
//           }
//         }

//         newHelpMarkers.add(
//           Marker(
//             markerId:
//                 MarkerId("help_${user.nic}"), // Use unique ID from database
//             position: userPosition,
//             infoWindow: InfoWindow(
//                 // title: user.user_name,
//                 // snippet: "${user.model} - ${user.vehicle_no}",
//                 ),
//             icon: userIcon,
//             onTap: () => selectedUserInfo(
//                 help_id: user.help_id ?? '',
//                 name: user.user_name,
//                 address: user.address,
//                 contact_no: user.contact_no,
//                 vehicle_no: user.vehicle_no,
//                 vehicle_image: user.image_link,
//                 vehicle_model: user.model),
//           ),
//         );
//       }

//       setState(() {
//         // Remove old help markers
//         _markers.removeAll(_helpMarkers);

//         // Add new help markers
//         _helpMarkers = newHelpMarkers;
//         _markers.addAll(_helpMarkers);
//       });
//     } catch (e) {
//       print("Error refreshing help markers: $e");
//     }
//   }

//   Future<BitmapDescriptor> getCustomMarkerFromNetwork(String imageUrl) async {
//     final Uint8List bytes =
//         (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
//             .buffer
//             .asUint8List();

//     final ui.Codec codec =
//         await ui.instantiateImageCodec(bytes, targetWidth: 100);
//     final ui.FrameInfo fi = await codec.getNextFrame();
//     final ByteData? byteData =
//         await fi.image.toByteData(format: ui.ImageByteFormat.png);
//     final Uint8List resizedBytes = byteData!.buffer.asUint8List();

//     return BitmapDescriptor.fromBytes(resizedBytes);
//   }

//   Future<void> _getCurrentLocation() async {
//     LocationPermission permission;
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) return;

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     LatLng pos = LatLng(position.latitude, position.longitude);

//     String? imageLink = await persistenceHelper.getSelectedVehicleImage();
//     BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

//     if (imageLink != null && imageLink.isNotEmpty) {
//       try {
//         customIcon = await getCustomMarkerFromNetwork(imageLink);
//       } catch (e) {
//         print("Failed to load current location image icon: $e");
//       }
//     }

//     setState(() {
//       _currentPosition = pos;
//       _markers.add(
//         Marker(
//           markerId: MarkerId("currentLocation"),
//           position: pos,
//           infoWindow: InfoWindow(title: "You are here"),
//           icon: customIcon,
//         ),
//       );
//     });

//     mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: pos, zoom: 15),
//       ),
//     );
//   }
//   Future<void> manualRefresh() async {
//     await _refreshHelpMarkers();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkHelpApprovalStatus();
//     fetchUserLocations();
//     isUser();
//     loadUsername();
//     _getCurrentLocation();
//     Timer.periodic(Duration(seconds: 2), (Timer timer) {
//       if (_currentPage < _images.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _pageController.animateToPage(
//         _currentPage,
//         duration: Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//     // Start periodic refresh for real-time updates
//     _startPeriodicRefresh();
//   }

//   @override
//   void dispose() {
//     _refreshTimer?.cancel();
//     super.dispose();
//   }

//   Future<void> fetchUserLocations() async {
//     List<MakeHelp> users = await getHelp.getMadeHelps();
//     Set<Marker> userMarkers = {};

//     print("User list length: ${users.length}");

//     for (int i = 0; i < users.length; i++) {
//       MakeHelp user = users[i];
//       LatLng userPosition = LatLng(user.latitude, user.longitude);

//       BitmapDescriptor userIcon =
//           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

//       if (user.image_link.isNotEmpty) {
//         try {
//           userIcon = await getCustomMarkerFromNetwork(user.image_link);
//         } catch (e) {
//           print("Error loading marker icon for ${user.user_name}: $e");
//         }
//       }

//       print(
//           "Adding marker for ${user.user_name} at ${user.latitude}, ${user.longitude}");

//       userMarkers.add(
//         Marker(
//           markerId: MarkerId("help_${user.nic}"), // Use unique ID from database
//           position: userPosition,
//           infoWindow: InfoWindow(
//             title: user.user_name,
//             snippet: "${user.model} - ${user.vehicle_no}",
//           ),
//           icon: userIcon,
//         ),
//       );
//     }

//     setState(() {
//       _helpMarkers = userMarkers;
//       _markers.addAll(userMarkers);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Color(0xFF000b58),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 "WELCOME",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: AppConfig.font_bold_family,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20),
//               ),
//               Center(
//                 child: Text(
//                   username ?? 'Guest',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: AppConfig.font_bold_family,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15),
//                 ),
//               ),
//               SizedBox(
//                 height: w * 0.05,
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 10, right: 10),
//                 width: w * 0.98,
//                 height: w * 0.50,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 1),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Stack(
//                     children: [
//                       PageView.builder(
//                         scrollDirection: Axis.horizontal,
//                         controller: _pageController,
//                         itemCount: _images.length,
//                         itemBuilder: (context, index) {
//                           return Image.asset(
//                             _images[index],
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           );
//                         },
//                       ),
//                       // Black Gradient Overlay
//                       Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.black.withOpacity(0.4), // Top fade
//                               Colors.black.withOpacity(0.6), // Bottom darker
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: w * 0.20,
//                         left: w * 0.22,
//                         child: Container(
//                           width: w * 0.50,
//                           height: w * 0.15,
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Get help for your requirement",
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: AppConfig.font_bold_family,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(2),
//                 margin: EdgeInsets.only(
//                   top: 15,
//                   left: 10,
//                   right: 10,
//                 ),
//                 height: w * 0.9,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10.0),
//                   ),
//                 ),
//                 child: Container(
//                   child: _currentPosition == null
//                       ? Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: GoogleMap(
//                             onMapCreated: (GoogleMapController controller) {
//                               mapController = controller;
//                             },
//                             initialCameraPosition: CameraPosition(
//                               target: _currentPosition!,
//                               zoom: 15.0,
//                             ),
//                             scrollGesturesEnabled: true,
//                             myLocationEnabled: true,
//                             myLocationButtonEnabled: true,
//                             markers: _markers,
//                             zoomControlsEnabled: true,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: isUserAccount == true
//           ? AnimatedNotchBottomBar(
//               durationInMilliSeconds: 500,
//               notchBottomBarController: _controller,
//               bottomBarItems: [
//                 BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.home_filled,
//                     color: Colors.black,
//                   ),
//                   activeItem: Icon(
//                     Icons.home_filled,
//                     color: Colors.black,
//                   ),
//                   itemLabel: 'Home',
//                 ),
//                 BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.history,
//                     color: Colors.black,
//                   ),
//                   activeItem: Icon(
//                     Icons.history,
//                     color: Colors.black,
//                   ),
//                   itemLabel: 'History',
//                 ),
//                 BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.person,
//                     color: Colors.black,
//                   ),
//                   activeItem: Icon(
//                     Icons.person,
//                     color: Colors.black,
//                   ),
//                   itemLabel: 'Account',
//                 ),
//               ],
//               onTap: (value) {
//                 _controller.index = value;
//                 if (kDebugMode) {
//                   print("Selected index: $value");
//                 }
//                 switch (value) {
//                   case 0:
//                     break;

//                   case 1:
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             HistoryUser(),
//                         transitionsBuilder:
//                             (context, animation, secondaryAnimation, child) =>
//                                 FadeTransition(
//                           opacity: animation,
//                           child: child,
//                         ),
//                       ),
//                     );
//                     break;
//                   case 2:
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             UserAccountPage(),
//                         transitionsBuilder:
//                             (context, animation, secondaryAnimation, child) =>
//                                 FadeTransition(
//                           opacity: animation,
//                           child: child,
//                         ),
//                       ),
//                     );
//                     break;
//                 }
//               },
//               kIconSize: 30,
//               kBottomRadius: 12.0,
//             )
//           : AnimatedNotchBottomBar(
//               durationInMilliSeconds: 500,
//               notchBottomBarController: _controller_technician,
//               bottomBarItems: [
//                 BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.home_filled,
//                     color: Colors.black,
//                   ),
//                   activeItem: Icon(
//                     Icons.home_filled,
//                     color: Colors.black,
//                   ),
//                   itemLabel: 'Home',
//                 ),
//                 BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.history,
//                     color: Colors.black,
//                   ),
//                   activeItem: Icon(
//                     Icons.history,
//                     color: Colors.black,
//                   ),
//                   itemLabel: 'History',
//                 ),
//                 BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.person,
//                     color: Colors.black,
//                   ),
//                   activeItem: Icon(
//                     Icons.person,
//                     color: Colors.black,
//                   ),
//                   itemLabel: 'Account',
//                 ),
//               ],
//               onTap: (value) {
//                 _controller.index = value;
//                 if (kDebugMode) {
//                   print("Selected index: $value");
//                 }
//                 switch (value) {
//                   case 0:
//                     break;

//                   case 1:
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             TechnicianHistory(),
//                         transitionsBuilder:
//                             (context, animation, secondaryAnimation, child) =>
//                                 FadeTransition(
//                           opacity: animation,
//                           child: child,
//                         ),
//                       ),
//                     );
//                     break;
//                   case 2:
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             UserAccountPage(),
//                         transitionsBuilder:
//                             (context, animation, secondaryAnimation, child) =>
//                                 FadeTransition(
//                           opacity: animation,
//                           child: child,
//                         ),
//                       ),
//                     );
//                     break;
//                 }
//               },
//               kIconSize: 30,
//               kBottomRadius: 12.0,
//             ),
//     );
//   }
// }
import 'dart:async';
import 'dart:ui' as ui;
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

class _DashboardTechnicianState extends State<DashboardTechnician>
    with WidgetsBindingObserver {
  String? username;
  final PageController _pageController = PageController();
  final PersistenceHelper persistenceHelper = PersistenceHelper();
  final GetHelp getHelp = GetHelp();
  int _currentPage = 0;
  bool? isUserAccount;
  GoogleMapController? mapController;
  Timer? _refreshTimer;
  Timer? _pageTimer;

  // Keep track of help request markers separately
  Set<Marker> _helpMarkers = {};
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};

  // Add polylines set
  final Set<Polyline> _polylines = {};

  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  final NotchBottomBarController _controller_technician =
      NotchBottomBarController(index: 0);

  final List<String> _images = [
    'assets/images/dashboard/repair_image.png',
    'assets/images/dashboard/repair_image2.png',
    'assets/images/dashboard/repair_image3.png',
  ];

  bool? isApprovedHelp;
  bool _isDisposed = false; // Add this flag to track disposal state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer for app lifecycle
    _initializeData();
  }

  // Separate initialization method
  Future<void> _initializeData() async {
    if (_isDisposed) return; // Check if disposed

    try {
      checkHelpApprovalStatus();
      await isUser();
      loadUsername();
      await _getCurrentLocation();
      await fetchUserLocations();

      // Start timers only if not disposed
      if (!_isDisposed) {
        _startPageTimer();
        _startPeriodicRefresh();
      }
    } catch (e) {
      print("Error in initialization: $e");
    }
  }

  // Separate method for page timer
  void _startPageTimer() {
    _pageTimer?.cancel(); // Cancel existing timer
    _pageTimer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_isDisposed || !mounted) {
        timer.cancel();
        return;
      }

      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      // Check if PageController is still valid
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true; // Set disposal flag
    WidgetsBinding.instance.removeObserver(this);

    // Cancel all timers
    _refreshTimer?.cancel();
    _pageTimer?.cancel();

    // Dispose controllers
    _pageController.dispose();

    // Clear collections
    _markers.clear();
    _helpMarkers.clear();
    _polylines.clear();

    // Set controllers to null
    mapController = null;

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        _refreshTimer?.cancel();
        _pageTimer?.cancel();
        break;
      case AppLifecycleState.resumed:
        if (!_isDisposed && mounted) {
          _startPeriodicRefresh();
          _startPageTimer();
        }
        break;
      default:
        break;
    }
  }

  void loadUsername() async {
    if (_isDisposed) return;

    try {
      username = await persistenceHelper.getName();
      print("Username from SharedPreferences: $username");
      if (mounted) setState(() {});
    } catch (e) {
      print("Error loading username: $e");
    }
  }

  void checkHelpApprovalStatus() async {
    if (_isDisposed) return;

    try {
      isApprovedHelp = await persistenceHelper.getApproveHelp();
      if (mounted) {
        setState(() {});
      }

      if (isApprovedHelp == true) {
        print("Help request is approved");
      } else {
        print("Help request is not approved");
      }
    } catch (e) {
      print("Error checking help approval status: $e");
    }
  }

  // Add method to create polyline between two points
  void _createPolyline(LatLng start, LatLng end, String polylineId) {
    if (_isDisposed || !mounted) return;

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId(polylineId),
          points: [start, end],
          color: Colors.blue,
          width: 5,
          patterns: [PatternItem.dash(20), PatternItem.gap(10)],
        ),
      );
    });
  }

  // Remove specific polyline
  void _removePolyline(String polylineId) {
    if (_isDisposed || !mounted) return;

    setState(() {
      _polylines
          .removeWhere((polyline) => polyline.polylineId.value == polylineId);
    });
  }

  // Clear all polylines
  void _clearAllPolylines() {
    if (_isDisposed || !mounted) return;

    setState(() {
      _polylines.clear();
    });
  }

  void selectedUserInfo({
    required String help_id,
    required String name,
    required String vehicle_image,
    required String vehicle_no,
    required String vehicle_model,
    required String contact_no,
    required String address,
    required double latitude,
    required double longitude,
  }) {
    if (_isDisposed || !mounted) return;

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                        child: vehicle_image.isNotEmpty
                            ? Image.network(
                                vehicle_image,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/default_vehicle.png',
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/default_vehicle.png',
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 16),
                      Text(name,
                          style: TextStyle(
                              fontFamily: AppConfig.font_bold_family,
                              fontSize: 20)),
                      Text(vehicle_no,
                          style: TextStyle(
                              fontFamily: AppConfig.font_bold_family,
                              fontSize: 20)),
                      Text(vehicle_model,
                          style: TextStyle(
                              fontFamily: AppConfig.font_bold_family,
                              fontSize: 20)),
                      Text(contact_no,
                          style: TextStyle(
                              fontFamily: AppConfig.font_bold_family,
                              fontSize: 20)),
                      Text(address,
                          style: TextStyle(
                              fontFamily: AppConfig.font_bold_family,
                              fontSize: 20)),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            print("Contact Number is: $contact_no");
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
                            isApprovedHelp == false
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF000b58),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () async {
                                      try {
                                        bool isApprovedHelp = await getHelp
                                            .approveHelpRequest(help_id);

                                        if (isApprovedHelp) {
                                          await persistenceHelper
                                              .setApproveHelp(isApprovedHelp);
                                          checkHelpApprovalStatus();

                                          // Create polyline when approved
                                          if (_currentPosition != null &&
                                              !_isDisposed &&
                                              mounted) {
                                            LatLng userLocation =
                                                LatLng(latitude, longitude);
                                            _createPolyline(_currentPosition!,
                                                userLocation, "route_$help_id");

                                            // Optionally adjust camera to show both points
                                            _adjustCameraToShowBothPoints(
                                                _currentPosition!,
                                                userLocation);
                                          }

                                          print(
                                              "Help request approved successfully");
                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Help request approved and route displayed")),
                                            );
                                          }
                                        } else {
                                          await persistenceHelper
                                              .setApproveHelp(isApprovedHelp);
                                          print(
                                              "Failed to approve help request");
                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Failed to approve help request")),
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        print(
                                            "Error approving help request: $e");
                                      }

                                      if (mounted) Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Approve",
                                      style: TextStyle(
                                        color: const ui.Color.fromARGB(
                                            255, 233, 232, 232),
                                        fontFamily: AppConfig.font_bold_family,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () async {
                                      try {
                                        bool isCancelledApproval = await getHelp
                                            .cancelApprovedHelpRequest(help_id);

                                        if (isCancelledApproval) {
                                          await persistenceHelper
                                              .setApproveHelp(false);
                                          checkHelpApprovalStatus();

                                          // Remove polyline when cancelled
                                          _removePolyline("route_$help_id");

                                          if (mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Successfully cancelled the approved request")),
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        print("Error cancelling approval: $e");
                                      }

                                      if (mounted) Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Not Approve",
                                      style: TextStyle(
                                        color: Colors.white,
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
                              onPressed: () {
                                if (mounted) Navigator.pop(context);
                              },
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

  // Method to adjust camera to show both driver and user locations
  void _adjustCameraToShowBothPoints(LatLng point1, LatLng point2) {
    if (_isDisposed || mapController == null) return;

    try {
      double minLat =
          point1.latitude < point2.latitude ? point1.latitude : point2.latitude;
      double maxLat =
          point1.latitude > point2.latitude ? point1.latitude : point2.latitude;
      double minLng = point1.longitude < point2.longitude
          ? point1.longitude
          : point2.longitude;
      double maxLng = point1.longitude > point2.longitude
          ? point1.longitude
          : point2.longitude;

      mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          100.0, // padding
        ),
      );
    } catch (e) {
      print("Error adjusting camera: $e");
    }
  }

  Future<void> isUser() async {
    if (_isDisposed) return;

    try {
      bool userType = await persistenceHelper.getAccountType() == "User";
      if (mounted) {
        setState(() {
          isUserAccount = userType;
        });
      }
    } catch (e) {
      print("isUser error: $e");
    }
  }

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel(); // Cancel existing timer
    _refreshTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_isDisposed || !mounted) {
        timer.cancel();
        return;
      }
      _refreshHelpMarkers();
    });
  }

  Future<void> _refreshHelpMarkers() async {
    if (_isDisposed || !mounted) return;

    try {
      List<MakeHelp> users = await getHelp.getMadeHelps();
      Set<Marker> newHelpMarkers = {};

      print("Refreshing help markers. Found ${users.length} active helps");

      for (int i = 0; i < users.length; i++) {
        if (_isDisposed) return; // Check disposal during loop

        MakeHelp user = users[i];
        LatLng userPosition = LatLng(user.latitude, user.longitude);

        BitmapDescriptor userIcon =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

        if (user.image_link.isNotEmpty) {
          try {
            print("Help id: ${user.help_id}");
            userIcon = await getCustomMarkerFromNetwork(user.image_link);
          } catch (e) {
            print("Error loading marker icon for ${user.user_name}: $e");
          }
        }

        newHelpMarkers.add(
          Marker(
            markerId: MarkerId("help_${user.nic}"),
            position: userPosition,
            infoWindow: InfoWindow(),
            icon: userIcon,
            onTap: () => selectedUserInfo(
              help_id: user.help_id ?? '',
              name: user.user_name,
              address: user.address,
              contact_no: user.contact_no,
              vehicle_no: user.vehicle_no,
              vehicle_image: user.image_link,
              vehicle_model: user.model,
              latitude: user.latitude,
              longitude: user.longitude,
            ),
          ),
        );
      }

      if (mounted && !_isDisposed) {
        setState(() {
          _markers.removeAll(_helpMarkers);
          _helpMarkers = newHelpMarkers;
          _markers.addAll(_helpMarkers);
        });
      }
    } catch (e) {
      print("Error refreshing help markers: $e");
    }
  }

  Future<BitmapDescriptor> getCustomMarkerFromNetwork(String imageUrl) async {
    if (_isDisposed) return BitmapDescriptor.defaultMarker;

    try {
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
    } catch (e) {
      print("Error creating custom marker: $e");
      return BitmapDescriptor.defaultMarker;
    }
  }

  Future<void> _getCurrentLocation() async {
    if (_isDisposed) return;

    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      if (_isDisposed) return; // Check after async operation

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

      if (mounted && !_isDisposed) {
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
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  Future<void> manualRefresh() async {
    if (!_isDisposed && mounted) {
      await _refreshHelpMarkers();
    }
  }

  Future<void> fetchUserLocations() async {
    if (_isDisposed) return;

    try {
      List<MakeHelp> users = await getHelp.getMadeHelps();
      Set<Marker> userMarkers = {};

      print("User list length: ${users.length}");

      for (int i = 0; i < users.length; i++) {
        if (_isDisposed) return; // Check disposal during loop

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
            markerId: MarkerId("help_${user.nic}"),
            position: userPosition,
            infoWindow: InfoWindow(
              title: user.user_name,
              snippet: "${user.model} - ${user.vehicle_no}",
            ),
            icon: userIcon,
            onTap: () => selectedUserInfo(
              help_id: user.help_id ?? '',
              name: user.user_name,
              address: user.address,
              contact_no: user.contact_no,
              vehicle_no: user.vehicle_no,
              vehicle_image: user.image_link,
              vehicle_model: user.model,
              latitude: user.latitude,
              longitude: user.longitude,
            ),
          ),
        );
      }

      if (mounted && !_isDisposed) {
        setState(() {
          _helpMarkers = userMarkers;
          _markers.addAll(userMarkers);
        });
      }
    } catch (e) {
      print("Error fetching user locations: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDisposed) return Container();
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
              SizedBox(height: w * 0.05),
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
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.6),
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
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                height: w * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Container(
                  child: _currentPosition == null
                      ? Center(child: CircularProgressIndicator())
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              if (!_isDisposed) {
                                mapController = controller;
                              }
                            },
                            initialCameraPosition: CameraPosition(
                              target: _currentPosition!,
                              zoom: 15.0,
                            ),
                            scrollGesturesEnabled: true,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            markers: _markers,
                            polylines: _polylines,
                            zoomControlsEnabled: true,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      /* body: SafeArea(
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
              SizedBox(height: w * 0.05),
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
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.6),
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
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                height: w * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Container(
                  child: _currentPosition == null
                      ? Center(child: CircularProgressIndicator(),)
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
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            markers: _markers,
                            polylines: _polylines, // Add polylines to the map
                            zoomControlsEnabled: true,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      */
      // ... rest of the bottomNavigationBar code remains the same
      bottomNavigationBar: isUserAccount == true
          ? AnimatedNotchBottomBar(
              durationInMilliSeconds: 500,
              notchBottomBarController: _controller,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(Icons.home_filled, color: Colors.black),
                  activeItem: Icon(Icons.home_filled, color: Colors.black),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.history, color: Colors.black),
                  activeItem: Icon(Icons.history, color: Colors.black),
                  itemLabel: 'History',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.person, color: Colors.black),
                  activeItem: Icon(Icons.person, color: Colors.black),
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
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UserAccountPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
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
                  inActiveItem: Icon(Icons.home_filled, color: Colors.black),
                  activeItem: Icon(Icons.home_filled, color: Colors.black),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.history, color: Colors.black),
                  activeItem: Icon(Icons.history, color: Colors.black),
                  itemLabel: 'History',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.person, color: Colors.black),
                  activeItem: Icon(Icons.person, color: Colors.black),
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
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UserAccountPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
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
