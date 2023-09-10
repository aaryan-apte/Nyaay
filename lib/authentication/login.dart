import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';

class MyLogin extends StatefulWidget {

  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLogin1State();
}

class _MyLogin1State extends State<MyLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  TextStyle textStyle = TextStyle(fontFamily: 'CrimsonText-Regular.ttf');

  // final database = ;

  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 90
              ),
              const SizedBox(
                height: 45.0
              ),
              const Text(
                'Save More with MyMoney',
                style: TextStyle(
                  fontFamily: 'CrimsonText',
                  // fontStyle: FontStyle.italic,
                  fontSize: 30.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle:
                    TextStyle(color: Colors.black54, fontSize: 18.0)),
              ),
              const SizedBox(
                height: 5
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle:
                    TextStyle(color: Colors.black54, fontSize: 18.0)),
              ),
              const SizedBox(
                height: 30
              ),
              SizedBox(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.blue[900]),
                  ),
                  onPressed: () {
                    logIn();
                  },
                  icon: const Icon(Icons.lock_open_rounded),
                  label: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CrimsonText',
                        fontSize: 16),
                    'New to us?  ',
                  ),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontFamily: 'CrimsonText',
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Ram(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future logIn() async {
    // showDialog(
    //   context: context,
    //   builder: (context) => Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );

    // final scaffold_key = GlobalKey<ScaffoldMessengerState>();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}