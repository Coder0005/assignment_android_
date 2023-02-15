import 'package:flutter/material.dart';

import 'package:freelancer_app/models/Hirings.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Hirings extends StatefulWidget {
  var userID;
  Hirings({Key? key, @required this.userID}) : super(key: key);

  @override
  State<Hirings> createState() => _HiringsState();
}

class _HiringsState extends State<Hirings> {
  var hirings;
  var hiringJson;

  final List<Hiring> _hirings = <Hiring>[];
  Future getHiring() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/hires/showHires"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        hiringJson = (json.decode(response.body));

        for (var hire in hiringJson) {
          _hirings.add(Hiring.fromJson(hire));
        }
      });
    } else {
      setState(() {
        // listResponse = {};
      });
    }
  }

  Widget showHirings(freelancer, gig, rate, category, image) {
    return Card(
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
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Freelancer Name : ',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '$freelancer',
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Gig : ",
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$gig",
            style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Category : ",
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$category",
            style: const TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Rs $rate",
            style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getHiring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Hirings"),
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
              child: (_hirings.isEmpty)
                  ? const Text("No hirings retrived from the server!")
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return showHirings(
                          hiringJson[index]["worker"],
                          hiringJson[index]["gigTitle"],
                          hiringJson[index]["gigRate"],
                          hiringJson[index]["gigCategory"],
                          hiringJson[index]["gigImage"],
                        );
                      },
                      itemCount: hiringJson.length,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
