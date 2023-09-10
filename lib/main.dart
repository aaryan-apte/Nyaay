import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nyaay/authentication/login.dart';
import 'package:nyaay/authentication/signup.dart';
// import 'package:nyaay/pages/home.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: const MyRegister(),
      theme: ThemeData(
        fontFamily: 'CrimsonText',
      ),
    ),
  );
}
