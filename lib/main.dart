import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nyaay/authentication/first1.dart';
// import 'package:nyaay/authentication/first_screen.dart';
// import 'package:nyaay/authentication/login.dart';
// import 'package:nyaay/authentication/signup.dart';
// import 'package:nyaay/authentication/willpop_checker_user.dart;
import 'package:nyaay/pages/user/home/home1.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final Locale locale = Locale('en');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: const HomeU(),

      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade500,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color.fromARGB(255, 69, 0, 114)),
        fontFamily: 'CrimsonText',
      ), 
    ),
  );
}