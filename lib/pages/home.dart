import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/user_signup.dart';

class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {

  Future<List<DocumentSnapshot>> fetchLawyers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('profession', isEqualTo: 'lawyer')
        .get();

    return querySnapshot.docs;
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: FutureBuilder(
              future: fetchLawyers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Data has been fetched successfully.
                  final lawyers = snapshot.data;

                  // if (lawyers.isEmpty) {
                  //   return Text('No lawyers found.');
                  // }

                  // Render the data (e.g., create a ListView of lawyers).
                  return ListView.builder(
                    itemCount: lawyers?.length,
                    itemBuilder: (context, index) {
                      var lawyerData = lawyers![index].data() as Map<String, dynamic>;

                      // Access fields like 'name', 'email', etc.
                      String name = lawyerData['name'];

                      return ListTile(
                        title: Text("Lawyers only! $name"),
                        // subtitle: Text(email),
                      );
                    },
                  );
                }
              },
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: (){
              signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterUser()));
            },
              child: const Text("Sign Out")
          )
        ],
      )


    );
  }
}
