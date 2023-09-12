import 'package:flutter/material.dart';
// import 'package:nyaay/authentication/service_login.dart';
// import 'package:nyaay/authentication/user_login.dart';
import 'package:nyaay/authentication/willpop_checker_service.dart';
import 'package:nyaay/authentication/willpop_checker_user.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome to Nyaay..."),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthUser()));
              },
                  child: Text("User Login")),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthService()));
              }, child: Text("Service Login"))
            ],
          ),
        ),
      ),
    );
  }
}
