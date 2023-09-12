import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nyaay/authentication/first1.dart';
import 'package:nyaay/authentication/first_screen.dart';
// import 'package:nyaay/authentication/login.dart';
// import 'package:nyaay/authentication/signup.dart';
import 'package:nyaay/authentication/willpop_checker_user.dart';
// import 'package:nyaay/pages/home_pages/home.dart';

// import 'package:nyaay/pages/home/home.dart';
// import 'package:nyaay/pages/home.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final Locale locale = Locale('en');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: const AuthStart(),
      // home: const Authenticate2(),

      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade500,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color.fromARGB(255, 69, 0, 114)),
        fontFamily: 'CrimsonText',
      ), 
    ),
  );
}