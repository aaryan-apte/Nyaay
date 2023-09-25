import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/home/completed_appoinments.dart';

class PaymentRequests extends StatefulWidget {
  const PaymentRequests({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<PaymentRequests> createState() => _PaymentRequestsState();
}

class _PaymentRequestsState extends State<PaymentRequests> {
  late String userEmail;
  @override
  initState() {
    super.initState();
    userEmail = widget.userEmail;
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
          .where('status', isEqualTo: 0)
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

        if (requestData['status'] == false) {
          requestList.add(requestData);
        }
      }
    } catch (e) {
      throw ('Error fetching requests: $e');
    }
    return requestList;
  }

  deleteRequest(String lawyerEmail, String time) async {
    final email = FirebaseAuth.instance.currentUser?.email;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('lawyer')
        .doc(lawyerEmail)
        .collection('requests')
        .where('email', isEqualTo: email)
        .where('time', isEqualTo: time)
        .get();

    QuerySnapshot q = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('requests')
        .where('time', isEqualTo: time)
        .get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
    for (QueryDocumentSnapshot documentSnapshot in q.docs) {
      await documentSnapshot.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.secondary
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0, // Remove the shadow
        toolbarHeight: 70,
        title: Row(
          children: [
            const Text(
              'Payment Requests',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Center(
        // child: Text("You have no pending appointments"),
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
                  return const Text('No Requests made yet.',
                      style: TextStyle(color: Colors.red));
                } else {
                  List<Map<String, dynamic>>? requestList = snapshot.data;
                  return ListView.builder(
                    itemCount: requestList?.length,
                    itemBuilder: (context, index) {
                      // final name = requestList![index]["name"];
                      final lawyerName = requestList![index]["lawyerName"];
                      final lawyerEmail = requestList[index]["lawyerEmail"];
                      final request = requestList[index]["request"];
                      // final status = requestList[index]['status'];
                      final date = requestList[index]['date'];
                      final time = requestList[index]['time'];

                      // return const Center(
                      //   child: Text(
                      //     "No pending appointments.",
                      //     style: TextStyle(color: Colors.black),
                      //   ),
                      // );

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
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
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
                                            " Adv. $lawyerName",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   children: [
                                      //     const Icon(
                                      //        Icons.email,
                                      //       color: Color.fromARGB(255, 12, 12, 12),
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
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              deleteRequest(lawyerEmail, time);
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) => UserRequestLawyer(
                                              //       lawyerName: name,
                                              //       lawyerEmail: "aaryan3108@gmail.com",
                                              //     ),
                                              //   ),
                                              // );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 197, 197, 197),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Text(
                                                "Cancel Appointment",
                                                style: textStyle,
                                              ),
                                            ),
                                          ),
                                          //        TextButton(
                                          //        onPressed: () {
                                          //        Navigator.push(
                                          //          context,
                                          //          MaterialPageRoute(
                                          //            builder: (context) => RateReview(
                                          //              lawyerName: lawyerName,
                                          //              lawyerEmail: lawyerEmail,
                                          //              uname: name,
                                          //            ),
                                          //          ),
                                          //        );
                                          //  },
                                          //  child: Container(
                                          //        padding: const EdgeInsets.all(10.0),
                                          //        decoration: BoxDecoration(
                                          //            color: const Color.fromARGB(255, 197, 197, 197),
                                          //            borderRadius:
                                          //                BorderRadius.circular(10.0)),
                                          //        child: Text(
                                          //          "Write a Review",
                                          //          style: textStyle,
                                          //        ),
                                          //  ),
                                          // ),
                                        ],
                                      )
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
