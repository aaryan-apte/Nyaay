// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/authentication/service_login.dart';
import 'package:nyaay/pages/home_pages_service/home_service.dart';
// import 'package:nyaay/pages/home_pages_user/home.dart';
// import 'login.dart';


class AuthService extends StatelessWidget {
  const AuthService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: WillPopScope(
      onWillPop: () async => false,
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
            return HomeS();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong.'),
            );
          } else {
            return const ServiceLogin();
          }
        },
      ),
    ),
  );
}
