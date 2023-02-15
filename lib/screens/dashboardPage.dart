import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/aboutUsPage.dart';
import 'package:freelancer_app/screens/homepage.dart';
import 'package:freelancer_app/screens/loginpage.dart';
import 'package:freelancer_app/screens/notifications.dart';
import 'package:freelancer_app/screens/profilePage.dart';
import 'package:shake/shake.dart';

class DashboardScreen extends StatefulWidget {
  var userID;

  DashboardScreen({Key? key, @required this.userID}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    ShakeDetector.autoStart(onPhoneShake: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<StatefulWidget> screens = [
      HomePageScreen(
        userID: widget.userID,
      ),
      const NotificationScreen(),
      ProfilePageScreen(
        userID: widget.userID,
      ),
      const AboutUsPage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.green,
        showSelectedLabels: true,
        selectedFontSize: 15,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black87,
              size: 30.0,
            ),
            label: "Home",
            // backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.black87,
              size: 30.0,
            ),
            label: "Notifications",
            // backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black87,
              size: 30.0,
            ),
            label: "Profile",
            // backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.question_answer,
              color: Colors.black87,
              size: 30.0,
            ),
            label: "About Us",
            // backgroundColor: Colors.red,
          ),
        ],
      ),
      body: IndexedStack(index: currentIndex, children: screens),
    );
  }
}
