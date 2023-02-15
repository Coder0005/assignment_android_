import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/yourGigs.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class AddGigScreen extends StatefulWidget {
  var userID;
  AddGigScreen({Key? key, @required this.userID}) : super(key: key);

  @override
  State<AddGigScreen> createState() => _AddGigScreenState();
}

class _AddGigScreenState extends State<AddGigScreen> {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  // String encoded = stringToBase64.encode("myImage");

  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          // img = File(image.path);
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  var titleController = TextEditingController();
  var techniqueController = TextEditingController();
  var descriptionController = TextEditingController();
  var rateController = TextEditingController();

  var statusReceived;

  Future addGig() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/gig/addGig/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <dynamic, dynamic>{
          'title': titleController.text,
          'category': categoryChoose.toString(),
          'technique': techniqueController.text,
          'description': descriptionController.text,
          'rate': rateController.text,
          'userID': widget.userID,
          // 'image': img
        },
      ),
    );

    if (response.statusCode == 200) {
      setState(
        () {
          statusReceived = response.body.toString();
        },
      );

      if (statusReceived == "1") {
        MotionToast(
                primaryColor: Colors.green,
                width: 320,
                title: const Text("Success"),
                description: const Text("The Gig was successfully added!"),
                icon: Icons.add_box_outlined)
            .show(context);

        reset();
      } else {
        MotionToast(
                primaryColor: Colors.red,
                width: 320,
                title: const Text("Failure"),
                description: const Text("The gig couldn't be added!"),
                icon: Icons.error)
            .show(context);
      }
    } else {
      MotionToast(
              primaryColor: Colors.green,
              width: 320,
              title: const Text("Failure"),
              description:
                  const Text("Didn't receive expected response from the API!"),
              icon: Icons.add_box_outlined)
          .show(context);
    }
  }

  Widget _displayImage() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
      child: ClipRRect(
        // For rounded upper right corner and left corner in imageview
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: img == null
                    ? Image.asset(
                        'assets/defaultGigImage.jpg',
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                      )
                    : SizedBox(
                        child: Image.file(
                          img!,
                          fit: BoxFit.fitWidth,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      titleController.clear();
      techniqueController.clear();
      descriptionController.clear();
      rateController.clear();
    });
  }

  String? categoryChoose;
  List listItem = [
    "I.T & Tech",
    "Art & Music",
    "Legal Works",
    "Graphics & Multimedia",
    "miscellaneous",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
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
                child: (const Icon(Icons.swipe_left)),
              ),
              _displayImage(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _loadImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera_enhance),
                      label: const Text('Open Camera'),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _loadImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.browse_gallery_sharp),
                      label: const Text('Open Gallery'),
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                    ),
                  ),
                ],
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.brown),
                ),
                style: const TextStyle(color: Colors.brown),
                controller: titleController,
              ),
              DropdownButton(
                  hint: const Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text(
                      "Select Category",
                    ),
                  ),
                  dropdownColor: Colors.blueGrey,
                  isExpanded: true,
                  value: categoryChoose,
                  icon: const Icon(Icons.category),
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 150),
                        child: Text(valueItem),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      categoryChoose = newValue.toString();
                    });
                  }),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Tools & Techniquies",
                  hintStyle: TextStyle(color: Colors.brown),
                ),
                style: const TextStyle(color: Colors.brown),
                controller: techniqueController,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.brown),
                ),
                style: const TextStyle(color: Colors.brown),
                controller: descriptionController,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Rate",
                  hintStyle: TextStyle(color: Colors.brown),
                ),
                style: const TextStyle(color: Colors.brown),
                controller: rateController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addGig();
                    },
                    child: const Text("Add Gig"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: reset,
                    child: const Text("Reset"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
