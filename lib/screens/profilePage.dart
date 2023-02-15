import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/dashboardPage.dart';
import 'package:freelancer_app/screens/hirings.dart';
import 'package:freelancer_app/screens/loginpage.dart';
import 'package:freelancer_app/screens/updateUser.dart';
import 'package:freelancer_app/screens/works.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';

class ProfilePageScreen extends StatefulWidget {
  var userID;
  ProfilePageScreen({Key? key, @required this.userID}) : super(key: key);

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  var userJson;
  var hirings;
  var hiringJson;
  var statusReceived;
  var earning;
  var investment;

  Future getProfile() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/users/profile"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        userJson = json.decode(response.body);
      });
    }
  }

  Future getEarning() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/hires/getEarning"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        earning = response.body.toString();
      });
    }
  }

  Future getInvestment() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/hires/getInvestment"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        investment = response.body.toString();
      });
    }
  }

  Future updateAccount() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateUser(
          userID: widget.userID,
        ),
      ),
    );
  }

  Future deleteAccount() async {
    http.Response response;

    response = await http.delete(
      Uri.parse("$baseUrl/users/deleteUser/${widget.userID}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        statusReceived = response.body.toString();
        if (statusReceived == "1") {
          Navigator.pushNamed(context, '/loginPage');
          MotionToast(
                  primaryColor: Colors.red,
                  width: 320,
                  title: const Text("Account Deleted"),
                  description: const Text("Good Bye Friend!"),
                  icon: Icons.login_rounded)
              .show(context);
        } else {
          MotionToast(
                  primaryColor: Colors.red,
                  width: 320,
                  title: const Text("Couldn't Delete Account"),
                  description: const Text(
                      "Some technical errors disrupted the deletion process!"),
                  icon: Icons.login_rounded)
              .show(context);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 204, 150, 175),
                  Color.fromARGB(255, 208, 118, 90)
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(
                                userID: widget.userID,
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.home),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48), // Image radius
                          child: Image.asset('assets/defaultDp.jpg',
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.blueGrey,
                        width: double.infinity,
                        height: 45,
                        alignment: Alignment.center,
                        child: const Text(
                          "Name : ",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Text(
                        "${userJson["firstName"]} ${userJson["lastName"]}",
                        style: const TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.blueGrey,
                        width: double.infinity,
                        height: 45,
                        alignment: Alignment.center,
                        child: const Text(
                          "Age : ",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Text(
                        "${userJson["age"]} Yrs",
                        style: const TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.blueGrey,
                        width: double.infinity,
                        height: 45,
                        alignment: Alignment.center,
                        child: const Text(
                          "Email : ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                        "${userJson["email"]}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.blueGrey,
                        width: double.infinity,
                        height: 45,
                        alignment: Alignment.center,
                        child: const Text(
                          "Address : ",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Text(
                        "${userJson["address"]}",
                        style: const TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.blueGrey,
                        width: double.infinity,
                        height: 45,
                        alignment: Alignment.center,
                        child: const Text(
                          "Username :",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Text(
                        "${userJson["username"]}",
                        style: const TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 10,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            child: const Text(
                              "Work History",
                              style: TextStyle(fontSize: 25),
                            ),
                            color: Colors.green,
                            width: double.infinity / 2,
                            height: 45,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: ElevatedButton(
                              child: const Text("View"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Works(
                                      userID: widget.userID,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            child: const Text(
                              "Hire History",
                              style: TextStyle(fontSize: 25),
                            ),
                            color: Colors.green,
                            width: double.infinity,
                            height: 45,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.yellow),
                              child: const Text(
                                "View",
                                style: TextStyle(
                                  color: Colors.purple,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Hirings(
                                      userID: widget.userID,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            child: const Text(
                              "Total Earning:",
                              style: TextStyle(fontSize: 25),
                            ),
                            color: Colors.green,
                            width: double.infinity,
                            height: 45,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.lightGreen),
                              child: Text(earning != null
                                  ? "Rs $earning"
                                  : "Calculate!"),
                              onPressed: () {
                                getEarning();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: const Text(
                              "Total Investment:",
                              style: TextStyle(fontSize: 25),
                            ),
                            color: Colors.green,
                            width: double.infinity,
                            height: 45,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              child: Text(investment != null
                                  ? "Rs $investment"
                                  : "Calculate!"),
                              onPressed: () {
                                getInvestment();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: const Text(
                              "Account Actions",
                              style: TextStyle(fontSize: 25),
                            ),
                            color: Colors.green,
                            width: double.infinity,
                            height: 45,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 119, 107, 7)),
                              child: const Text("Update Account"),
                              onPressed: updateAccount,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color.fromARGB(66, 54, 5, 1)),
                              child: const Text("Sign Out"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: const Text("Delete Account"),
                                onPressed: deleteAccount),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
