import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/wearOS/wearOSHome.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:wear/wear.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(List<String> args) {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: WearOsScreen()),
  );
}

class WearOsScreen extends StatefulWidget {
  const WearOsScreen({Key? key}) : super(key: key);

  @override
  State<WearOsScreen> createState() => _WearOsScreenState();
}

class _WearOsScreenState extends State<WearOsScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var result = 0;

  void ininState() {
    super.initState();
  }

  static var userID;

  String getUserID() {
    return userID;
  }

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
            builder: (context) => WearOsHome(
              userID: userID,
            ),
          ),
        );
        const snackBar = SnackBar(
          content: Text('Logged In'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (statusReceived == "2") {
        const snackBar = SnackBar(
          content: Text('Invalid Credentials!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: Stack(
                  children: [
                    Container(
                      height: 500,
                      width: 500,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 19, 152, 182),
                            Color.fromARGB(255, 180, 70, 36)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            "Login Page",
                            style: TextStyle(color: Colors.amber),
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'Enter Username',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                            controller: usernameController,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: const Text("Login"),
                              onPressed: authentication,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: reset,
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            );
          },
        );
      },
    );
  }
}
