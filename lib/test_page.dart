import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/widgets/vehicle_card.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: VehicleCard(
                  image: "assets/images/add_vehicle/car1.png",
                  vehicle_name: "MARUTI SUZUKI ALTO",
                  vehicle_no: "WP-CAD-5617",
                  color: "GREY",
                  year: "2017",
                ),
              ),
              VehicleCard(
                image: "assets/images/add_vehicle/car1.png",
                vehicle_name: "MARUTI SUZUKI ALTO",
                vehicle_no: "WP-CAD-5617",
                color: "GREY",
                year: "2017",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
