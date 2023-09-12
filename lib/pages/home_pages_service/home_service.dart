import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/first_screen.dart';

class HomeS extends StatefulWidget {
  const HomeS({Key? key}) : super(key: key);

  @override
  State<HomeS> createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Center(
        child: TextButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => FirstPage(),
              ),
            );
        }, child: Text("Hare Krishna, SignOut!")),
      ),
    );
  }
}
