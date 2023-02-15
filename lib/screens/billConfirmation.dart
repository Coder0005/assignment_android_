import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/dashboardPage.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:motion_toast/motion_toast.dart';

class BillConfirmationPage extends StatefulWidget {
  dynamic userID;
  dynamic title;
  dynamic category;
  dynamic technique;
  dynamic description;
  dynamic rate;
  dynamic gigID;
  dynamic workerID;
  dynamic freelancerName;
  dynamic image;
  BillConfirmationPage(
      {Key? key,
      @required this.userID,
      @required this.title,
      @required this.category,
      @required this.technique,
      @required this.description,
      @required this.rate,
      @required this.gigID,
      @required this.workerID,
      @required this.freelancerName,
      @required this.image})
      : super(key: key);

  @override
  State<BillConfirmationPage> createState() => _BillConfirmationPageState();
}

class _BillConfirmationPageState extends State<BillConfirmationPage> {
  var statusReceived;
  void hire(client, worker, gigID) async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/hires/addHire"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          'client': client,
          'worker': worker,
          'gig': gigID,
        },
      ),
    );

    if (response.statusCode == 200) {
      setState(
        () {
          statusReceived = response.body.toString();

          if (statusReceived == "1") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(
                  userID: widget.userID,
                ),
              ),
            );
            MotionToast(
                    primaryColor: const Color.fromARGB(255, 1, 136, 1),
                    width: 320,
                    title: const Text("Gig Hired!"),
                    description:
                        const Text("Your hiring has been added to the DB!"),
                    icon: Icons.sell)
                .show(context);
          } else {
            MotionToast(
                    primaryColor: Colors.red,
                    width: 320,
                    title: const Text("Couldn't Hire"),
                    description: const Text("Could not add the hiring to DB!"),
                    icon: Icons.error)
                .show(context);
          }
        },
      );
    }
  }

  // dynamic x, y, z;

  // @override
  // void initState() {
  //   userAccelerometerEvents.listen((UserAccelerometerEvent event) {
  //     setState(() {
  //       x = event.x;
  //       y = event.y;
  //       z = event.z;
  //     });
  //   });
  // }

  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
      setState(() {
        _proximityValue = event.proximity;
      });
      if (_proximityValue < 1) {
        // Get.to(() => const UserScreen());

        hire(widget.userID, widget.workerID, widget.gigID);
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: const Color.fromARGB(255, 22, 72, 132),
              elevation: 10,
              child: Column(
                children: [
                  // Text(x ?? "0"),
                  const Text(
                    "Confirmation Bill",
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  SizedBox(
                    child: Image.network(
                      'https://res.cloudinary.com/dr27vplim/image/upload/v1658865564/${widget.image}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Freelancer : ",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.freelancerName}",
                    style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Gig Title : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.title}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Category : ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 215, 114, 114),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.category}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 182, 100, 100),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Technique : ",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.technique}",
                    style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Total Rs.  ${widget.rate}",
                    style: const TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                        onPressed: () {
                          hire(widget.userID, widget.workerID, widget.gigID);
                        },
                        child: const Icon(Icons.done),
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
          ),
        ),
      ),
    );
  }
}
