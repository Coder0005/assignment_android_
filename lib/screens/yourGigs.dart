import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer_app/models/Gigs.dart';
import 'package:freelancer_app/screens/addGig.dart';
import 'package:freelancer_app/screens/dashboardPage.dart';
import 'package:freelancer_app/screens/updateGig.dart';
import 'package:freelancer_app/utils/urls.dart';

import 'package:http/http.dart' as http;

class YourGigsScreen extends StatefulWidget {
  var userID;
  YourGigsScreen({Key? key, @required this.userID}) : super(key: key);

  @override
  State<YourGigsScreen> createState() => _YourGigsScreenState();
}

class _YourGigsScreenState extends State<YourGigsScreen> {
  final List<Gig> _gigs = <Gig>[];

  var gigsJson;
  var statusReceived;

  Future getGig() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/gig/userGig"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{'userID': widget.userID},
      ),
    );

    var gigs = <Gig>[];

    if (response.statusCode == 200) {
      setState(() {
        gigsJson = json.decode(response.body);

        for (var gigJson in gigsJson) {
          _gigs.add(Gig.fromJson(gigJson));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGig();
  }

  bool _showState = true;

  void changeState() {
    setState(() {
      _showState = false;
    });
  }

  Widget gigBox(String title, String category, String technique,
      String description, String rate, String id, dynamic image) {
    return Visibility(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: Colors.blueGrey,
        elevation: 10,
        child: Column(
          children: [
            SizedBox(
              child: Image.network(
                'https://res.cloudinary.com/dr27vplim/image/upload/v1658865564/$image.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 25, 3, 122),
                    Color.fromARGB(255, 130, 144, 8)
                  ],
                ),
              ),
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
                      description,
                      style: const TextStyle(
                          color: Colors.black,
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
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UpdateGigScreen(
                                        id: id, userID: widget.userID)));
                              },
                              child: const Icon(Icons.edit),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              )),
                          ElevatedButton(
                            onPressed: () async {
                              http.Response response;

                              response = await http.delete(
                                Uri.parse("$baseUrl/gig/deleteGig/"),
                                headers: {"Content-Type": "application/json"},
                                body: jsonEncode(
                                  <String, String>{
                                    'id': id,
                                  },
                                ),
                              );
                              if (response.statusCode == 200) {
                                setState(() {
                                  statusReceived = response.body.toString();
                                });

                                if (statusReceived == "1") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => YourGigsScreen(
                                        userID: widget.userID,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Icon(Icons.delete),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
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
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
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
            child: (const Icon(Icons.swipe_left)),
          ),
          const Text("Your Gigs"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddGigScreen(
                    userID: widget.userID,
                  ),
                ),
              );
            },
            child: const Icon(Icons.add_box),
          ),
        ]),
        centerTitle: true,
        backgroundColor: Colors.green,
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
                  ? const Text("You don't have any gigs registered!")
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return gigBox(
                            gigsJson[index]["title"],
                            gigsJson[index]["category"],
                            gigsJson[index]["technique"],
                            gigsJson[index]["description"],
                            gigsJson[index]["rate"],
                            gigsJson[index]["_id"],
                            gigsJson[index]["image"]);
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
