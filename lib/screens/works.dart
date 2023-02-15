import 'package:flutter/material.dart';
import 'package:freelancer_app/models/Hirings.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Works extends StatefulWidget {
  var userID;
  Works({Key? key, @required this.userID}) : super(key: key);

  @override
  State<Works> createState() => _WorksState();
}

class _WorksState extends State<Works> {
  var userJson;
  var hirings;
  var hiringJson;
  var statusReceived;

  final List<Hiring> _hirings = <Hiring>[];
  Future getProfile() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/hires/showWorks"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        hiringJson = json.decode(response.body);

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

  Widget showWorks(client, gig, rate, category, image) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: const Color.fromARGB(255, 31, 0, 84),
      elevation: 10,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Client Name :',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '$client',
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Gig :",
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$gig",
            style: const TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Category : ",
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$category",
            style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Rs.$rate",
            style: const TextStyle(
                color: Colors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.network(
            'https://res.cloudinary.com/dr27vplim/image/upload/v1658865564/$image.png',
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Work History"),
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
                  ? const Text("You haven't worked yet!")
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return showWorks(
                          hiringJson[index]["client"],
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
