import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/dashboardPage.dart';

import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:freelancer_app/utils/urls.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void ininState() {
    _checkNotificationEnabled() {
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
    }

    super.initState();
  }

  static var userID;

  String getUserID() {
    return userID;
  }

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  List listResponse = [
    {""}
  ];

  String? statusReceived;
  bool signal = false;

  Future authentication() async {
    http.Response response;
    // response = await http.get(Uri.parse("http://localhost:90/user/login"));
    response = await http.post(Uri.parse("$baseUrl/users/login/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'username': usernameController.text,
          'password': passwordController.text
        }));

    if (response.statusCode == 200) {
      setState(() {
        var loginResponse = json.decode(response.body);
        userID = loginResponse["userID"];
        statusReceived = loginResponse["foundResponse"];
        signal = statusReceived == "1" ? true : false;
      });
      if (statusReceived == "1") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              userID: userID,
            ),
          ),
        );
        MotionToast(
                primaryColor: Colors.green,
                width: 320,
                title: const Text("Welcome!"),
                description: const Text("Logged In Successfully"),
                icon: Icons.login_rounded)
            .show(context);

        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: 'User Logged In',
              body: "You have just logged in!"),
        );
      } else if (statusReceived == "2") {
        MotionToast(
                primaryColor: Colors.red,
                width: 320,
                title: const Text("Wrong Password"),
                description: const Text("Password is invalid!"),
                icon: Icons.login_rounded)
            .show(context);
      } else {
        MotionToast(
                primaryColor: Colors.red,
                width: 320,
                title: const Text("Failed"),
                description: const Text("Invalid Credentials!"),
                icon: Icons.login_rounded)
            .show(context);
      }

      if (signal) {
      } else {}
    } else {
      setState(() {
        listResponse = ["Sorry", "The api didn't send an expected response!"];
      });
    }
  }

  void reset() {
    setState(() {
      usernameController.clear();
      passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/loginbg.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Login Page',
                  style: TextStyle(
                    color: Colors.lime,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter Username',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: usernameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: ElevatedButton(
                            onPressed: authentication,
                            child: const Icon(Icons.login),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: reset,
                            child: const Icon(Icons.delete),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registerPage');
                        },
                        child: const Icon(Icons.fork_right),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
