// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_app/models/Gigs.dart';
import 'package:freelancer_app/screens/billConfirmation.dart';
import 'package:freelancer_app/screens/profilePage.dart';
import 'package:freelancer_app/screens/yourGigs.dart';
import 'package:freelancer_app/utils/urls.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePageScreen extends StatefulWidget {
  var userID;
  HomePageScreen({Key? key, @required this.userID}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final List<Gig> _gigs = <Gig>[];

  var gigsJson;
  var statusReceived;

  Future getGig() async {
    http.Response response;

    response = await http.get(
      Uri.parse("$baseUrl/gig/showGig"),
    );

    if (response.statusCode == 200) {
      setState(() {
        gigsJson = json.decode(response.body);

        for (var gigJson in gigsJson) {
          _gigs.add(Gig.fromJson(gigJson));
        }
      });
    }
  }

  var userJson;
  var username;

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
        username = userJson["username"];
      });
    }
  }

  void hire(title, category, technique, description, rate, gigID, workerID,
      freelancerName, image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillConfirmationPage(
            userID: widget.userID,
            title: title,
            category: category,
            technique: technique,
            description: description,
            rate: rate,
            gigID: gigID,
            workerID: workerID,
            freelancerName: freelancerName,
            image: image),
      ),
    );
  }

  bool _showState = true;

  void changeState() {
    setState(() {
      _showState = false;
    });
  }

  final List<double> _accelerometerValues = <double>[];
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];
  // ignore: non_constant_identifier_names

  @override
  void initState() {
    getGig();
    getProfile();
    // _streamSubscription.add(
    //   accelerometerEvents!.listen(
    //     (AccelerometerEvent event) {
    //       setState(() {
    //         _accelerometerValues = <double>[event.x, event.y, event.z];
    //       });
    //       if (_accelerometerValues[0] > 0.2) {
    //         Get.to(() => const LoginPage());
    //       }
    //     },
    //   ),
    // );
    super.initState();
  }

  Future<void> _launchURLBrowser() async {
    String url = 'https://flutterdevs.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget gigBox(
      String title,
      String category,
      String technique,
      String description,
      String rate,
      String gigID,
      String workerID,
      String? freelancerName,
      String? image) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: const Color.fromARGB(255, 31, 0, 84),
        elevation: 10,
        child: Column(
          children: [
            SizedBox(
              child: Image.network(
                'https://res.cloudinary.com/dr27vplim/image/upload/v1658865564/$image.png',
                fit: BoxFit.contain,
              ),
            ),
            Card(
              elevation: 50,
              child: Container(
                width: double.infinity,
                color: const Color.fromARGB(255, 255, 17, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Freelancer : ",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      freelancerName ?? "N/A",
                      style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Category : $category',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Technique : $technique",
                      style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      " ''$description'' ",
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Rs.  $rate",
                      style: const TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                  onPressed: () {
                    // hire(widget.userID, workerID, gigID);
                    hire(title, category, technique, description, rate, gigID,
                        workerID, freelancerName, image);
                  },
                  child: const Icon(Icons.card_travel),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hey, $username",
              style: const TextStyle(fontSize: 15),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePageScreen(
                      userID: widget.userID,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     const Icon(Icons.person),
              //     Text(
              //       '  Hey  $username',
              //       style: const TextStyle(fontSize: 15),
              //     )
              //   ],
              // ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Stack(
            children: [
              Image.asset(
                "assets/slabBg.jpg",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.green),
                    child: Container(
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(70), // Image radius
                          child: Image.asset(
                            "assets/freelanceNepalDp.jpg",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: _launchURLBrowser,
                    child: const Text("Visit Site"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/locateUs');
                    },
                    child: const Text("Locate Us"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YourGigsScreen(
                            userID: widget.userID,
                          ),
                        ),
                      );
                    },
                    child: const Text("Your Gigs"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginPage');
                    },
                    child: const Text("Log Out"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/dashboardDp.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: (_gigs.isEmpty)
                  ? const Text("No gigs retrived from the server!")
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return gigBox(
                          gigsJson[index]["title"],
                          gigsJson[index]["category"],
                          gigsJson[index]["technique"],
                          gigsJson[index]["description"],
                          gigsJson[index]["rate"],
                          gigsJson[index]["_id"],
                          gigsJson[index]["userID"],
                          gigsJson[index]["freelancerName"],
                          gigsJson[index]["image"],
                        );
                      },
                      itemCount: gigsJson.length,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
