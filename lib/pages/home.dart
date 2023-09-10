import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Ram extends StatefulWidget {
  const Ram({Key? key}) : super(key: key);

  @override
  State<Ram> createState() => _RamState();
}

class _RamState extends State<Ram> {

  Future<List<DocumentSnapshot>> fetchLawyers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('profession', isEqualTo: 'lawyer')
        .get();

    return querySnapshot.docs;
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
              onPressed: (){
            FirebaseAuth.instance.signOut();
            },
              child: const Text("Sign Out"))
        ],
      )


    );
  }
}
