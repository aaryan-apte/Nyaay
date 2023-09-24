import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final email = FirebaseAuth.instance.currentUser?.email;

  Future<Map<String, dynamic>> getUserInfo() async {
    Map<String, dynamic> map = {};

    map["email"] = email;

    final ref = await FirebaseFirestore.instance.collection('users').doc(email).get();

    map["name"] = ref.data()!['name'];
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile")
        ),
        body: FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red));
            } else if (!snapshot.hasData) {
              return const Text('No Requests made yet.',
                  style: TextStyle(color: Colors.red));
            } else {
              List<Map<String, dynamic>>? requestList = snapshot.data as List<Map<String, dynamic>>?;
              return ListView.builder(
                itemCount: requestList?.length,
                itemBuilder: (context, index) {
                  final name = requestList![index]["name"];

                  return Column(
                    children: [
                      Text(name),
                      // Text(email!),
                    ],
                  );

                },
              );
            }
          },
        ),
      ),
    );
  }
}
