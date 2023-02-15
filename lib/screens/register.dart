import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_app/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  dynamic fname;
  dynamic lname;
  dynamic email;
  dynamic address;
  dynamic age;
  dynamic password1;
  dynamic password2;

  // Creating the controllers for textformfields
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var ageController = TextEditingController();
  var usernameController = TextEditingController();
  var password1Controller = TextEditingController();
  var password2Controller = TextEditingController();

  void reset() {
    setState(() {
      fnameController.clear();
      lnameController.clear();
      emailController.clear();
      addressController.clear();
      usernameController.clear();
      ageController.clear();
      password1Controller.clear();
      password2Controller.clear();
    });
  }

// Load camera and gallery images and store it to the File object.
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

  Future registerUser() async {
    http.Response response;

    response = await http.post(
      Uri.parse("$baseUrl/users/adduser"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        <dynamic, dynamic>{
          'firstName': fnameController.text,
          'lastName': lnameController.text,
          'email': emailController.text,
          'address': addressController.text,
          'age': ageController.text,
          'username': usernameController.text,
          'password': password1Controller.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        statusReceived = response.body.toString();
      });

      if (statusReceived == "1") {
        MotionToast(
                primaryColor: Colors.green,
                width: 320,
                title: const Text("Success"),
                description: const Text("Account Registered!"),
                icon: Icons.add_box_outlined)
            .show(context);

        reset();
      } else {
        MotionToast(
                primaryColor: Colors.red,
                width: 320,
                title: const Text("Failure"),
                description: const Text("Account Registry Failed!"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset(
          //   "assets/registerPageBg.svg",
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          // fit: BoxFit.cover,
          // ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 44, 1, 21),
                  Color.fromARGB(255, 34, 18, 13)
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Container(
                  child: ListView(
                    children: [
                      const Center(
                        child: Text(
                          "Register Page",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
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
                              label: const Text('Cam'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _loadImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.image),
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
                      TextFormField(
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
                        controller: fnameController,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          lname = val;
                        },
                        controller: lnameController,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          email = val;
                        },
                        controller: emailController,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          address = val;
                        },
                        controller: addressController,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Age",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          age = val;
                        },
                        controller: ageController,
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Create Username",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          address = val;
                        },
                        controller: usernameController,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Create Password",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          password1 = val;
                        },
                        controller: password1Controller,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (val) {
                          password2 = val;
                        },
                        controller: password2Controller,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => registerUser(),
                            child: const Icon(Icons.send),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: reset,
                            child: const Icon(Icons.delete),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/loginPage');
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
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
