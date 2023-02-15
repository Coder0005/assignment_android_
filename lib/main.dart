import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/aboutUsPage.dart';
import 'package:freelancer_app/screens/addGig.dart';
import 'package:freelancer_app/screens/dashboardPage.dart';
import 'package:freelancer_app/screens/homepage.dart';
import 'package:freelancer_app/screens/locateUs.dart';
import 'package:freelancer_app/screens/loginpage.dart';
import 'package:freelancer_app/screens/notifications.dart';
import 'package:freelancer_app/screens/profilePage.dart';
import 'package:freelancer_app/screens/register.dart';
import 'package:freelancer_app/screens/test.dart';
import 'package:freelancer_app/screens/updateGig.dart';
import 'package:freelancer_app/screens/yourGigs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize('resource://drawable/icon', [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.green,
        importance: NotificationImportance.High,
        ledColor: Colors.white,
        channelShowBadge: true)
  ]);
  runApp(
    MaterialApp(
      initialRoute: '/loginPage',
      routes: {
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/aboutUsPage': (context) => const AboutUsPage(),
        '/notificationPage': (context) => const NotificationScreen(),
        '/dashboardPage': (context) => DashboardScreen(),
        '/homePage': (context) => HomePageScreen(),
        '/addGigPage': (context) => AddGigScreen(),
        '/profilePage': (context) => ProfilePageScreen(),
        '/updateGigPage': (context) => UpdateGigScreen(),
        '/yourGigsPage': (context) => YourGigsScreen(),
        '/test': (context) => const TextClass(),
        '/locateUs': (context) => const LocateUs()
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
