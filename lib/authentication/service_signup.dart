// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:nyaay/pages/user/home/home1.dart';
import 'login.dart';
import 'package:nyaay/pages/user/services/districts.dart';

class ServiceSignup extends StatefulWidget {
  const ServiceSignup({super.key});

  @override
  _ServiceSignupState createState() => _ServiceSignupState();
}

class _ServiceSignupState extends State<ServiceSignup> {
  String selectedProfession = 'Lawyer'; // Default profession
  List<String> professions = ['Lawyer', 'Notary', 'Mediator', 'Arbitrator'];

  int retainerFee = 0;
  int hearingFee = 0;



  List<String> indianStatesAndUTs = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    "Dadra and Nagar Haveli (UT)",
    "Daman and Diu (UT)",
    "Delhi (NCT)",
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
    'Delhi (National Capital Territory of Delhi)',
    'Puducherry (Pondicherry)'
  ];

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
  List<String> degrees = [];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final hearingFeesController = TextEditingController();
  final retainerFeesController = TextEditingController();
  final experienceController = TextEditingController();
  final descriptionController = TextEditingController();
  final feesController = TextEditingController();
  final practiceAreasController = TextEditingController();
  final courtController = TextEditingController();

  String selectedState = 'Select a State'; // Initial selected state
  String selectedDistrict = 'Select a District'; // Initial selected district

  addUser() async {
    try {
      if (selectedProfession == "Lawyer" &&
          selectedDistrict != 'Select a District' &&
          selectedState != 'Select a State') {
        final ref = FirebaseFirestore.instance
            .collection('lawyer')
            .doc(emailController.text.trim());
        await ref.set({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
          "district": selectedDistrict,
          "state": selectedState,
          "categories": selectedCategory,
          "rating": 4.0,
          "retainerFees" : int.parse(retainerFeesController.text.trim()),
          "hearingFees" : int.parse(hearingFeesController.text.trim()),
          "experience" : experienceController.text.trim(),
          "cases" : 0,
          "degrees" : degrees,
          "description": descriptionController.text.trim(),
          "practiceAreas": practiceAreasController.text.trim(),
          "courts": courtController.text.trim(),
        });
      } else {
        final ref = FirebaseFirestore.instance
            .collection(selectedProfession.toLowerCase())
            .doc(emailController.text.trim());
        await ref.set({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
          "district": selectedState,
          "state": selectedDistrict,
          "experience" : experienceController.text.trim(),
          "fees" : feesController.text.trim(),
          "rating": 4.0,
          "degrees" : degrees,
          "description": descriptionController.text.trim(),
          "practiceAreas": practiceAreasController.text.trim(),
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  signUp() async {
    final isValid = formKey.currentState!.validate();
    if (isValid == false) {
      return;
    }

    if (selectedDistrict == "Select a District" ||
        selectedState == "Select a State") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Select State and District")));
    } else {
      setState(() {
        _isLoading = true;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) async {
        await addUser();
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Account Created Successfully!")));
        ScaffoldMessenger.of(context).clearSnackBars();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeU()));
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  printData() {
    Map<String, dynamic> map = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "district": selectedDistrict,
      "state": selectedState,
      "categories": selectedCategory,
    };
    print(map);
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
                  height: 30,
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
                        // print(selectedCategory);
                        printData();
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
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: experienceController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Experience (in years)",
                    labelStyle:
                        TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
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
                SizedBox(height: 20.0),
                Center(
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
                      MultiSelectCard(value: 'L.L.B.', child: Text("L.L.B")
                        // label: '',
                        // child: getChild('assets/images/lawyer.png', 'Civil'),
                      ),
                      MultiSelectCard(
                          value: 'L.L.M', child: Text("L.L.M")
                        // child:
                        // getChild('assets/images/lawyer.png', 'Corporate'),
                      ),
                      MultiSelectCard(
                          value: 'B.Com', child: Text('B.Com')
                        // child:
                        // getChild('assets/images/lawyer.png', 'Criminal'),
                      ),
                      MultiSelectCard(value: 'M.Com', child: Text('M.Com')
                        // child: getChild('assets/images/lawyer.png', 'Debt'),
                      ),
                      MultiSelectCard(value: 'Ph.D', child: Text("Ph.D")
                        // child: getChild('assets/images/lawyer.png', 'Family'),
                      ),
                      MultiSelectCard(
                          value: 'M.Sc', child: Text("M.Sc")
                        // getChild('assets/images/lawyer.png', 'Insurance'),
                      ),
                      MultiSelectCard(
                          value: 'B.Sc', child: Text("B.Sc")
                        // getChild('assets/images/lawyer.png', 'Property'),
                      ),
                      MultiSelectCard(value: 'B.A.', child: Text("B.A.")
                        // child: getChild('assets/images/lawyer.png', 'Others'),
                      ),
                      MultiSelectCard(value: 'M.A.', child: Text("M.A.")
                        // child: getChild('assets/images/lawyer.png', 'Others'),
                      ),
                    ],
                    onChange:
                        (List<String> selectedItems, String? selectedItem) {
                      degrees = selectedItems;
                      // print(selectedCategory);
                      printData();
                    },
                  ),
                ),
                Visibility(
                  visible: selectedProfession == 'Lawyer',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    controller: retainerFeesController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Retainer Fees",
                      labelStyle:
                      TextStyle(color: Colors.black54, fontSize: 18.0),
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedProfession == 'Lawyer',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    controller: hearingFeesController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Hearing Fees",
                      labelStyle:
                      TextStyle(color: Colors.black54, fontSize: 18.0),
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedProfession != 'Lawyer',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    controller: feesController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Fees",
                      labelStyle:
                      TextStyle(color: Colors.black54, fontSize: 18.0),
                    ),
                  ),
                ),
                DropdownButton(
                  value: selectedState,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedState = newValue!;
                      selectedDistrict = 'Select a District';
                    });
                  },
                  items: [
                    const DropdownMenuItem(
                      value: 'Select a State',
                      child: Text('Select a State'),
                    ),
                    ...indianStatesAndUTs
                        .map<DropdownMenuItem<String>>((String state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                  ],
                ),
                const SizedBox(height: 20.0),
                DropdownButton(
                  value: selectedDistrict,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDistrict = newValue!;
                    });
                  },
                  items: [
                    const DropdownMenuItem(
                      value: 'Select a District',
                      child: Text('Select a District'),
                    ),
                    if (districtsMap.containsKey(selectedState))
                      ...districtsMap[selectedState.toString()]!
                          .map((String district) {
                        return DropdownMenuItem(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                  ],
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
                TextFormField(
                  // keyboardType: TextInputType.number,
                  maxLines: 4,
                  maxLength: 100,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: descriptionController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Something about yourself (visible to the client)",
                    labelStyle:
                    TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),
                TextFormField(
                  // keyboardType: TextInputType.number,
                  maxLines: 1,
                  maxLength: 100,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: courtController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "In which courts do you practice",
                    labelStyle:
                    TextStyle(color: Colors.black54, fontSize: 18.0),
                  ),
                ),

                TextFormField(
                  // keyboardType: TextInputType.number,
                  maxLines: 2,
                  maxLength: 100,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  controller: practiceAreasController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Which areas do you practice (for the client)",
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
                      if (selectedCategory.isEmpty) {
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
