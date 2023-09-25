import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:nyaay/authentication/service_signup.dart';
// import 'package:nyaay/authentication/user_signup.dart';
// import 'package:nyaay/pages/home_pages_service/home_service.dart';
// import 'package:nyaay/pages/lawyer/home/home2.dart';
import 'package:nyaay/pages/user/home/home1.dart';
// import 'package:nyaay/pages/user/services/leader_board.dart';
// import 'authentication/service_login.dart';
// import 'authentication/user_login.dart';
import 'firebase_options.dart';

Future<void>main() async {
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