import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_app/utils/urls.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Notifications.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotiFication> _notifications = <NotiFication>[];

  var notificationsJson;

  Future getNotification() async {
    http.Response response;
    response = await http.get(
      Uri.parse("$baseUrl/notification/showNotification"),
    );

    var notifications = <NotiFication>[];
    if (response.statusCode == 200) {
      setState(() {
        notificationsJson = json.decode(response.body);
        for (var a in notificationsJson["notifications"]) {
          _notifications.add(NotiFication.fromJson(a));
        }
      });
    }
  }

  Widget notificationBuilder(
      notificationTitle, notificationDescription, notificationAbout, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: (index % 2 == 0)
            ? const Color.fromARGB(255, 92, 145, 210)
            : Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Title(
                color: const Color.fromARGB(255, 46, 168, 134),
                child: Text(
                  notificationTitle,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                " ' $notificationDescription ' ",
                style: const TextStyle(fontSize: 35, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Row(
                  children: [
                    Text(
                      notificationAbout,
                      style: const TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Notifications"),
            const Icon(
              Icons.notifications,
              size: 35,
            ),
            IconButton(
                onPressed: () {
                  // setState(() {
                  //   const NotificationScreen();
                  // });
                  Navigator.pushNamed(context, '/notificationPage');
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 177, 142, 15),
                  Color.fromARGB(255, 19, 157, 178)
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (_notifications.isEmpty)
                  ? const Text("No Notifications Received")
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return CarouselSlider(
                          items: [
                            notificationBuilder(
                                _notifications[index].title,
                                _notifications[index].description,
                                _notifications[index].about,
                                index)
                          ],
                          options: CarouselOptions(
                            height: 360.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        );
                      },
                      itemCount: _notifications.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
