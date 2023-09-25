import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/home/completed_appoinments.dart';
import 'package:nyaay/pages/user/home/payment_requests.dart';
import 'package:nyaay/pages/user/home/view_appoinments.dart';


Color PrimaryColor = Color(0xff3f51b5);

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);
  @override
  _AppointmentsState createState() => _AppointmentsState();
  
}

class _AppointmentsState extends State<Appointments> {
  String userEmail = "";
  //
  // Future<void> fetchUserEmail() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       userEmail = user.email ?? 'No email available';
  //     } else {
  //       userEmail = 'No user is currently logged in';
  //     }
  //   } catch (e) {
  //     // Handle any Firebase-related exceptions here
  //     userEmail = 'Error: $e';
  //   }
  // }

  

  int currindex = 0;
  void onTap(int index) {
    setState(() {
      currindex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;

    
  @override

      List pages = [
      const PaymentRequests(),
      const UserAppointments(),
      const UserCAppointments(),
    ];


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[currindex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currindex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          //showSelectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(label: ("Payment Requests"), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: ("Call Requests"), icon: Icon(Icons.newspaper)),
            BottomNavigationBarItem(
                label: ("Past Appointments"), icon: Icon(Icons.calculate)),
          ],
        ),
      ),
    );
  }
}
