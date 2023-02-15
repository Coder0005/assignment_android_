import 'package:flutter/material.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WearOsHome extends StatefulWidget {
  var userID;
  WearOsHome({Key? key, @required this.userID}) : super(key: key);

  @override
  State<WearOsHome> createState() => _WearOsHomeState();
}

class _WearOsHomeState extends State<WearOsHome> {
  var userJson;
  var earning;
  var investment;
  var gigCount;
  var hireCount;
  var workCount;
  Future getProfile() async {
    http.Response response;

    response = await http.post(
      Uri.parse("http://10.0.2.2:90/users/profile"),
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
      Uri.parse("http://10.0.2.2:90/hires/getEarning"),
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
      Uri.parse("http://10.0.2.2:90/hires/getInvestment"),
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

  Future getGigCount() async {
    http.Response response;

    response = await http.post(
      Uri.parse("http://10.0.2.2:90/gig/getGigCount"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        gigCount = response.body.toString();
      });
    }
  }

  Future getHireCount() async {
    http.Response response;

    response = await http.post(
      Uri.parse("http://10.0.2.2:90/gig/getHireCount"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        hireCount = response.body.toString();
      });
    }
  }

  Future getWorkCount() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/gig/getHireCount"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        workCount = response.body.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
    getEarning();
    getInvestment();
    getGigCount();
    getHireCount();
    getWorkCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.green),
                child: const Text("Your Account Status:"),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 108, 35, 191)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text("FirstName : ${userJson['firstName'].toString()}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("LastName : ${userJson['lastName'].toString()}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Age : ${userJson['age'].toString()}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Username : ${userJson['username'].toString()}"),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 204, 71, 84)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Gigs Count : "),
                        Text(gigCount != null ? "$gigCount" : "0"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Work Count : "),
                        Text(workCount != null ? "$workCount" : "0"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Hire Count : "),
                        Text(hireCount != null ? " $hireCount" : "0"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Earning : "),
                        Text(earning != null ? "Rs $earning" : "Rs.0"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Investment : "),
                        Text(investment != null ? "Rs $investment" : "Rs.0"),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
