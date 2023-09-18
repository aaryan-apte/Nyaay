// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:nyaay/pages/user/home/home1.dart';
import 'login.dart';

class ServiceSignup extends StatefulWidget {
  const ServiceSignup({super.key});

  @override
  _ServiceSignupState createState() => _ServiceSignupState();
}

class _ServiceSignupState extends State<ServiceSignup> {
  String selectedProfession = 'Lawyer'; // Default profession
  List<String> professions = ['Lawyer', 'Notary', 'Mediator', 'Arbitrator'];

  final MultiSelectController<String> _controller =
      MultiSelectController(deSelectPerpetualSelectedItems: false);

  Widget getChild(String imagePath, String title) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Expanded(
          //   child: Image.asset(
          //     imagePath, // Use the asset path instead of the network URL
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  List<String> selectedCategory = [];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final professionController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();

  FutureOr<void> addUser() async {
    // CollectionReference users = FirebaseFirestore.instance.collection('service');
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final String? uid = auth.currentUser?.email;
    // await users.doc(uid).set({
    //   'date': DateTime.now(),
    // });
    if(selectedProfession == "Lawyer"){
      final ref = FirebaseFirestore.instance
          .collection('lawyer')
          .doc(emailController.text.trim());
      await ref.set({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
        "city": cityController.text.trim(),
        "district": districtController.text.trim(),
        "state": stateController.text.trim(),
        "categories": selectedCategory,
      });
    }else{
      final ref = FirebaseFirestore.instance
          .collection(selectedProfession.toLowerCase())
          .doc(emailController.text.trim());
      await ref.set({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
        "city": cityController.text.trim(),
        "district": districtController.text.trim(),
        "state": stateController.text.trim(),
      });
    }

  }

  void signUp() {
    final isValid = formKey.currentState!.validate();
    if (isValid == false) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account Created Successfully!")));
      ScaffoldMessenger.of(context).clearSnackBars();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeU()));
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      throw "error";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: SingleChildScrollView(
          padding: EdgeInsets.all(22.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45.0,
                ),
                Text(
                  "Welcome to Nyaay...🙏",
                  style: TextStyle(
                    fontFamily: 'CrimsonText',
                    // fontStyle: FontStyle.italic,
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: nameController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5),
                DropdownButton(
                  value: selectedProfession,
                  // items: professions as List<DropdownMenuItem>,
                  onChanged: (newValue) {
                    setState(() {
                      selectedProfession = newValue!;
                    });
                  },
                  items:
                      professions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Visibility(
                  visible: selectedProfession == "Lawyer",
                  child: Center(
                    child: MultiSelectContainer(
                      itemsPadding: const EdgeInsets.all(10),
                      itemsDecoration: MultiSelectDecorations(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        selectedDecoration: BoxDecoration(
                          gradient: LinearGradient(colors: const [
                            Color.fromARGB(131, 0, 0, 0),
                            Color.fromARGB(255, 255, 251, 251)
                          ]),
                        ),
                      ),
                      controller: _controller,
                      // maxSelectableCount: 8,
                      items: [
                        MultiSelectCard(value: 'Civil', child: Text("Civil")
                            // label: '',
                            // child: getChild('assets/images/lawyer.png', 'Civil'),
                            ),
                        MultiSelectCard(
                            value: 'Corporate', child: Text("Corporate")
                            // child:
                            // getChild('assets/images/lawyer.png', 'Corporate'),
                            ),
                        MultiSelectCard(
                            value: 'Criminal', child: Text("Criminal")
                            // child:
                            // getChild('assets/images/lawyer.png', 'Criminal'),
                            ),
                        MultiSelectCard(value: 'Debt', child: Text("Debt")
                            // child: getChild('assets/images/lawyer.png', 'Debt'),
                            ),
                        MultiSelectCard(value: 'Family', child: Text("Family")
                            // child: getChild('assets/images/lawyer.png', 'Family'),
                            ),
                        MultiSelectCard(
                            value: 'Insurance', child: Text("Insurance")
                            // getChild('assets/images/lawyer.png', 'Insurance'),
                            ),
                        MultiSelectCard(
                            value: 'Property', child: Text("Property")
                            // getChild('assets/images/lawyer.png', 'Property'),
                            ),
                        MultiSelectCard(value: 'Others', child: Text("Others")
                            // child: getChild('assets/images/lawyer.png', 'Others'),
                            ),
                      ],
                      onChange:
                          (List<String> selectedItems, String? selectedItem) {
                        selectedCategory = selectedItems;
                        print(selectedCategory);
                      },
                    ),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: emailController,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email, true)
                          ? "Enter a valid email"
                          : null,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: professionController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Profession",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: phoneController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: cityController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "City",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: districtController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "District",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: stateController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "State",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? "Enter minimum 6 characters"
                      : null,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[900]),
                    ),
                    onPressed: () {
                      if (selectedCategory.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Select at least one category")));
                      }
                      signUp();
                    },
                    icon: Icon(Icons.lock_open_rounded),
                    label: _isLoading
                        ? SizedBox(
                            height: MediaQuery.of(context).size.width / 12,
                            width: MediaQuery.of(context).size.width / 12,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 1,
                            ),
                          )
                        : Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 17.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CrimsonText',
                          fontSize: 16),
                      'Already have an account?   ',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyLogin()));
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontFamily: 'CrimsonText',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
