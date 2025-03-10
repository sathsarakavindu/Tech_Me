import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tec_me/view/config/app.dart';

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
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 20,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
              margin: EdgeInsets.only(
                left: 2,
                right: 2,
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFD8D8D8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Good Morning!",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppConfig.font_bold_family,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      child: Image.asset(
                          width: w * 0.2,
                          height: w * 0.2,
                          "assets/images/drawer/ic_default_user.png"),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      "Roshan Rivishanka",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: AppConfig.font_bold_family,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      "roshanrivishanka99@gmail.com",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: AppConfig.font_bold_family,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
