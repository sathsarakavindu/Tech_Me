import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/vehicle_card.dart';
import 'package:tec_me/view_model/bloc/dashboardBloc/bloc/dashboard_bloc_bloc.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final DashboardBlocBloc dashboardBlocBloc = DashboardBlocBloc();

  final List<String> _images = [
    'assets/images/dashboard/repair_image.png',
    'assets/images/dashboard/repair_image2.png',
    'assets/images/dashboard/repair_image3.png',
  ];

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000b58),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer(
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
                            "Kavindu",
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
                          width: w * 0.80,
                          height: w * 0.50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
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
                                  left: w * 0.15,
                                  child: Container(
                                    width: w * 0.50,
                                    height: w * 0.10,
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
                      ],
                    ),
                  );
                default:
                  return SizedBox();
              }
            },
            listener: (context, state) {},
          ),
        ),
      ),
    );
  }
}

// Container(
                //   width: w * 0.80,
                //   height: w * 0.50,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20.0),
                //   ),
                //   child: Stack(
                //     children: [
                //       Container(
                //         width: w * 0.80,
                //         height: w * 0.50,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(20.0),
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.all(2.0),
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(20.0),
                //             child: Image.asset(
                //               "assets/images/dashboard/repair_image.png",
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       ),
                //       Positioned(
                //         top: w * 0.20,
                //         left: w * 0.15,
                //         child: Center(
                //           child: Container(
                //             // color: Colors.green,
                //             width: w * 0.50,
                //             height: w * 0.10,
                //             child: Text(
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //               textAlign: TextAlign.center,
                //               "Get help for your requirement",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontFamily: AppConfig.font_bold_family,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 15),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),