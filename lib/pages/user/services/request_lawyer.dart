//ignore_for_file: ignore_const_preferences
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/home/drawer.dart';

class UserRequestLawyer extends StatefulWidget {
  UserRequestLawyer(
      {super.key, required this.lawyerName, required this.lawyerEmail});

  String lawyerName, lawyerEmail;

  @override
  State<UserRequestLawyer> createState() => _UserRequestLawyerState();
}

class _UserRequestLawyerState extends State<UserRequestLawyer> {
  late String lawyerName, lawyerEmail;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lawyerEmail = widget.lawyerEmail;
    lawyerName = widget.lawyerName;
  }

  sendRequest() async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    // print(userEmail);
    final refL = FirebaseFirestore.instance
        .collection('lawyer')
        .doc('aaryan3108@gmail.com') // lawyerEmail
        .collection('requests');

    final refU = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('requests');

    try {
      await refL.add({
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "request": requestController.text.trim(),
        "date":
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
        "time":
            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
        "handled" : false,
      });

      await refU.add({
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "request": requestController.text.trim(),
        "date":
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
        "time":
            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
        "status": false,
      });
    } catch (e) {
      return SnackBar(content: Text(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        drawer: Drawer(
        child: AppDrawer(),
      ),
      
        body: Container(
           decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/lawbg2.jpg'), // Replace with your image path
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  ),
          // color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                
                  margin: const EdgeInsets.only(
                      top: 54.0, left: 11.0, right: 11.0, bottom: 54.0),
                  child: Container(
                     decoration: BoxDecoration(
                      // color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(16.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "You are contacting: ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Adv. $lawyerName",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 23.0,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      hintText: "Your Name",
                                      hintStyle:
                                          TextStyle(color: Colors.white38)),
                                  // keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      hintText: "Email Address",
                                      hintStyle:
                                          TextStyle(color: Colors.white38)),
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: TextField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                      hintText: "Phone Number",
                                      hintStyle:
                                          TextStyle(color: Colors.white38)),
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: TextField(
                                  maxLines: 7,
                                  controller: requestController,
                                  decoration: const InputDecoration(
                                      hintText: "Describe",
                                      hintStyle:
                                          TextStyle(color: Colors.white38)),
                                  // keyboardType: TextInputType,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              TextButton(
                                onPressed: () {
                                  sendRequest();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Send Request",
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
