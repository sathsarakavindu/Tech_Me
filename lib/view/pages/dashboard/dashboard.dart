import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';
import 'package:tec_me/view/widgets/drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
