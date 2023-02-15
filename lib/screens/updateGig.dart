import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/yourGigs.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class UpdateGigScreen extends StatefulWidget {
  final String? id;
  var userID;
  UpdateGigScreen({Key? key, @required this.id, @required this.userID})
      : super(key: key);

  @override
  State<UpdateGigScreen> createState() => _UpdateGigScreenState();
}

class _UpdateGigScreenState extends State<UpdateGigScreen> {
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
                    ? Container(
                        child: Image.network(
                          'https://images.unsplash.com/photo-1487073240288-854ac7f1bb3c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZnJlZWxhbmNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                        ),
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

  var gigsJson;
  var title;
  var categoryChoose;
  var technique;
  var description;
  var rate;
  // final List<Gig> _gigs = <Gig>[];

  Future getGig() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/gig/updateGig"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          'id': (widget.id).toString(),
        },
      ),
    );

    // var gigs = <Gig>[];

    if (response.statusCode == 200) {
      setState(() {
        gigsJson = json.decode(response.body);
        // _gigs.add(gigsJson);

        title = (gigsJson["title"]);
        categoryChoose = (gigsJson["category"]);
        technique = (gigsJson["technique"]);
        description = (gigsJson["description"]);
        rate = (gigsJson["rate"]);
      });
    } else {
      setState(() {
        // listResponse = {};
      });
    }
  }

  Widget myRandom(title, tools, description, rate) {
    return Column(
      children: [Text(title), Text(tools), Text(description), Text(rate)],
    );
  }

  @override
  void initState() {
    super.initState();
    getGig();
  }

  var titleController = TextEditingController(text: "mero title");
  var techniqueController = TextEditingController();
  var descriptionController = TextEditingController();
  var rateController = TextEditingController();

  var statusReceived;

  Future updateGig() async {
    http.Response response;

    response = await http.put(Uri.parse("$baseUrl/gig/updateGig/${widget.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'title': title,
          'category': categoryChoose,
          'technique': technique,
          'description': description,
          'rate': rate,
        }));

    if (response.statusCode == 200) {
      setState(() {
        statusReceived = response.body.toString();
      });

      if (statusReceived == "1") {
        MotionToast(
                primaryColor: Colors.green,
                title: const Text("Success"),
                description: const Text("The Gig was successfully updated!"),
                icon: Icons.add_box_outlined)
            .show(context);

        reset();
      } else {
        MotionToast(
                primaryColor: Colors.red,
                title: const Text("Failure"),
                description: const Text("The gig couldn't be updated!"),
                icon: Icons.error)
            .show(context);
      }
    } else {
      MotionToast(
              primaryColor: Colors.red,
              title: const Text("Failure"),
              description:
                  const Text("Didn't receive expected response from the API!"),
              icon: Icons.add_box_outlined)
          .show(context);
    }
  }

  // String? categoryChoose;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: false,
                  child: Column(
                    children: [
                      Text(title),
                      Text(technique),
                      Text(description),
                      Text(rate),
                    ],
                  ),
                ),
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
                  initialValue: title,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.brown),
                  ),
                  style: const TextStyle(color: Colors.brown),
                  onChanged: (val) => {title = val},
                  // controller: titleController,
                ),
                DropdownButton(
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 150),
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
                          padding: const EdgeInsets.only(left: 110),
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
                  initialValue: technique,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Tools & Techniquies",
                    hintStyle: TextStyle(color: Colors.brown),
                  ),
                  style: const TextStyle(color: Colors.brown),
                  onChanged: (val) => {technique = val},
                  // controller: techniqueController,
                ),
                TextFormField(
                  initialValue: description,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.brown),
                  ),
                  style: const TextStyle(color: Colors.brown),
                  onChanged: (val) => {description = val},
                  // controller: descriptionController,
                ),
                TextFormField(
                  initialValue: rate,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Rate",
                    hintStyle: TextStyle(color: Colors.brown),
                  ),
                  style: const TextStyle(color: Colors.brown),
                  onChanged: (val) => {rate = val},
                  // controller: rateController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateGig();
                      },
                      child: const Text("Update Gig"),
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
      ),
    );
  }
}
