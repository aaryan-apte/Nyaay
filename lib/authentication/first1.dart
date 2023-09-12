// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/authentication/first_screen.dart';
// import 'package:nyaay/authentication/service_login.dart';
import 'package:nyaay/pages/home_pages_service/home_service.dart';

import '../pages/home_pages_user/home.dart';
// import 'package:nyaay/pages/home_pages_user/home.dart';
// import 'login.dart';


class AuthStart extends StatelessWidget {
  const AuthStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: WillPopScope(
      onWillPop: () async => true,
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {
            String? email = FirebaseAuth.instance.currentUser?.email;

            if (email != null) {
              DocumentReference documentReference =
              FirebaseFirestore.instance.collection('service').doc(email);

              documentReference.get().then((documentSnapshot) {
                if (documentSnapshot.exists) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeS()));
                  // The document with the specified email exists
                  // You can access document data using documentSnapshot.data()
                  // For example, to access a field named 'fieldName':
                  // var fieldValue = documentSnapshot.data()['fieldName'];
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeU()));
                }
              }).catchError((error) {
                throw("Error: $error");
              });
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong.'),
            );
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FirstPage()));
          }

          return FirstPage();
        },
      ),
    ),
  );
}
