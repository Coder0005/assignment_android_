import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/screens/profilePage.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:motion_toast/motion_toast.dart';

class UpdateUser extends StatefulWidget {
  var userID;
  UpdateUser({Key? key, required this.userID}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  var userJson;

  dynamic fname;
  dynamic lname;
  dynamic email;
  dynamic address;
  dynamic age;
  dynamic username;
  dynamic password;

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

        fname = userJson['firstName'];
        lname = userJson['lastName'];
        email = userJson['email'];
        address = userJson['address'];
        age = userJson['age'];
        username = userJson['username'];
        password = userJson['password'];
      });
    }
  }

  // Load camera and gallery images and store it to the File object.
  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
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
                        child: Image.asset(
                          'assets/defaultDp.jpg',
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                        ),
                      )
                    : SizedBox(
                        child: Image.file(
                          img!,
                          fit: BoxFit.fill,
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

  var statusReceived;
  Future updateUser() async {
    http.Response response;

    response =
        await http.put(Uri.parse("$baseUrl/users/updateUser/${widget.userID}"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(<String, String>{
              'firstName': fname,
              'lastName': lname,
              'email': email,
              'address': address,
              'age': age,
              'username': username,
              'password': password,
            }));
    if (response.statusCode == 200) {
      setState(() {
        statusReceived = response.body.toString();
      });

      if (statusReceived == "1") {
        MotionToast(
                primaryColor: Colors.green,
                width: 320,
                title: const Text("Success"),
                description: const Text("Account Is Updated!"),
                icon: Icons.add_box_outlined)
            .show(context);
      } else {
        MotionToast(
                primaryColor: Colors.red,
                width: 320,
                title: const Text("Failure"),
                description: const Text("The account couldn't be updated!"),
                icon: Icons.error)
            .show(context);
      }
    } else {
      MotionToast(
              primaryColor: Colors.red,
              width: 320,
              title: const Text("Failure"),
              description:
                  const Text("Didn't receive expected response from the API!"),
              icon: Icons.add_box_outlined)
          .show(context);
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
                  Color.fromARGB(255, 132, 43, 5),
                  Color.fromARGB(255, 30, 1, 60)
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Container(
                  child: ListView(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            FloatingActionButton(
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
                              child: const Text("Back"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Please Edit The Fields",
                              style: TextStyle(
                                color: Color.fromARGB(255, 193, 193, 193),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                              label: const Text('Camera'),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 194, 38, 41)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _loadImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.image_search),
                              label: const Text('Gallery'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.brown),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        fname,
                        style: const TextStyle(fontSize: 1),
                      ),
                      Container(
                        child: const Text("First Name"),
                        color: Colors.green,
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                        initialValue: fname,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          fname = val;
                        },
                      ),
                      Container(
                        child: const Text("Last Name"),
                        color: Colors.green,
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                        initialValue: lname,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          lname = val;
                        },
                      ),
                      Container(
                        child: const Text("Email"),
                        color: Colors.green,
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                        initialValue: email,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Container(
                        child: const Text("Address"),
                        color: Colors.green,
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                        initialValue: address,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          address = val;
                        },
                      ),
                      Container(
                        child: const Text("Age"),
                        color: Colors.green,
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                        initialValue: age,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Age",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          age = val;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      Container(
                        child: const Text("Username"),
                        color: Colors.green,
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                        initialValue: username,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Create Username",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          username = val;
                        },
                      ),
                      Container(
                        child: const Text("Password"),
                        color: Colors.green,
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                      ),
                      TextFormField(
                        initialValue: password,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Your Password",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ElevatedButton(
                            child: const Text("Update Account"),
                            onPressed: updateUser),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
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
