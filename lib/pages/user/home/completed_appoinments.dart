import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/home/view_appoinments.dart';
// import 'package:nyaay/pages/user/services/request_lawyer.dart';
// import 'package:nyaay/pages/user/services/lawyer_detail_page.dart';
import 'package:nyaay/pages/user/home/drawer.dart';

import '../services/rate_review.dart';
// import 'dart:math';

class UserCAppointments extends StatefulWidget {
  const UserCAppointments({super.key, required this.userEmail});

final String userEmail;

  @override
  State<UserCAppointments> createState() => _UserCAppointmentsState();
}

class _UserCAppointmentsState extends State<UserCAppointments> {
  late String userEmail;
  @override
  initState() {
    super.initState();
    userEmail = widget.userEmail;
    // uname = widget.uname;
  }

  TextStyle textStyle =
      const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15.0);

  Future<List<Map<String, dynamic>>> getRequests(String userEmail) async {
    List<Map<String, dynamic>> requestList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .collection('requests')
          .where('status', isEqualTo: true)
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> requestData = {
          'email': doc['email'],
          'date': doc['date'],
          'time': doc['time'],
          'name': doc['name'],
          'phone': doc['phone'],
          'request': doc['request'],
          'status': doc['status'],
          'lawyerName': doc['lawyerName'],
          'lawyerEmail': doc['lawyerEmail'],
        };

        if (requestData['status'] == true) {
          requestList.add(requestData);
        }
      }
    } catch (e) {
      throw ('Error fetching requests: $e');
    }
    return requestList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0, // Remove the shadow
        toolbarHeight: 100,
        title: Row(
          children: [
            const Text(
              'Past Requests',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(width: 70.0),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              // width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(140, 142, 142, 142),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserAppointments(userEmail: userEmail),
                    ),
                  )
                },
                child: Row(
                  children: const [
                    SizedBox(height: 8.0),
                    Text(
                      "View Pending Requests",
                      style: TextStyle(
                        color: Color.fromARGB(255, 19, 19, 19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: FutureBuilder(
              future: getRequests(userEmail),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.brown,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red));
                } else if (!snapshot.hasData) {
                  return const Text(
                    'No Requests made yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                    ),
                  );
                } else {
                  List<Map<String, dynamic>>? requestList = snapshot.data;
                  return ListView.builder(
                    itemCount: requestList?.length,
                    itemBuilder: (context, index) {
                      final name = requestList![index]["name"];
                      final lawyerName = requestList![index]["lawyerName"];
                      final lawyerEmail = requestList[index]["lawyerEmail"];
                      final request = requestList[index]["request"];
                      // final status = requestList[index]['status'];
                      final date = requestList[index]['date'];
                      final time = requestList[index]['time'];

                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.4), // Shadow color
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset:
                                        const Offset(0, 3), // Shadow position
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.account_box_sharp,
                                            color:
                                                Color.fromARGB(255, 12, 12, 12),
                                            size: 20.0,
                                          ),
                                          Text(
                                            lawyerName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   children: [
                                      //     const Icon(
                                      //       Icons.email,
                                      //       color:
                                      //           Color.fromARGB(255, 12, 12, 12),
                                      //       size: 20.0,
                                      //     ),
                                      //     Text(
                                      //       lawyerEmail,
                                      //       style: const TextStyle(
                                      //           fontWeight: FontWeight.w100,
                                      //           fontSize: 15.0),
                                      //     ),
                                      //   ],
                                      // ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: SizedBox(
                                          width: 320,
                                          child: Text(
                                            "$request",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 13.0),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Request sent on: $date at $time",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0),
                                      ),
                                      const SizedBox(height: 10),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => RateReview(
                                                lawyerName: lawyerName,
                                                lawyerEmail: lawyerEmail,
                                                uname: name,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(255, 197, 197, 197),
                                              borderRadius:
                                              BorderRadius.circular(10.0)),
                                          child: Text(
                                            "Write a Review",
                                            style: textStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
