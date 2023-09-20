// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeL extends StatefulWidget {
  const HomeL({Key? key}) : super(key: key);

  @override
  State<HomeL> createState() => _HomeLState();
}

class _HomeLState extends State<HomeL> {
  getPendingAppointments() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    final ref = await FirebaseFirestore.instance
        .collection('lawyer')
        .doc(email)
        .collection('requests')
        .where('status', isEqualTo: 0)
        .get();

    List<Map<String, dynamic>> map = [];

    for (var doc in ref.docs) {
      map.add({
        'name': doc['name'],
        'email': doc['email'],
        'phone': doc['phone'],
        'request': doc['request'],
        'time': doc['time'],
        'date': doc['date'],
        "docID": doc.id,
      });
    }
    return map;
  }

  getPastAppointments() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    final ref = await FirebaseFirestore.instance
        .collection('lawyer')
        .doc(email)
        .collection('requests')
        .where('status', isEqualTo: 1)
        .get();

    List<Map<String, dynamic>> map = [];

    for (var doc in ref.docs) {
      map.add({
        'name': doc['name'],
        'email': doc['email'],
        'phone': doc['phone'],
        'request': doc['request'],
        'time': doc['time'],
        'date': doc['date'],
      });
    }
    return map;
  }

  markAsDone(String docID) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    await FirebaseFirestore.instance
        .collection('lawyer')
        .doc(email)
        .collection('requests')
        .doc(docID)
        .update({"status": 1})
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Marked as Done."),
        ),
      ),
    )
        .onError(
          (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      ),
    );
  }

  reject(String docID) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    await FirebaseFirestore.instance
        .collection('lawyer')
        .doc(email)
        .collection('requests')
        .doc(docID)
        .update({"status": 2})
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Request Rejected."),
        ),
      ),
    )
        .onError(
          (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text(
              "Nyaay",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      "Pending Appointments",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: FutureBuilder(
                          future: getPendingAppointments(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.brown,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}',
                                  style: const TextStyle(color: Colors.red));
                            } else if (snapshot.hasData == false) {
                              return const Text(
                                  'You have no upcoming appointments',
                                  style: TextStyle(color: Colors.red));
                            } else {
                              List<Map<String, dynamic>>? appointmentsList =
                              snapshot.data as List<Map<String, dynamic>>?;
                              return ListView.builder(
                                itemCount: appointmentsList?.length,
                                itemBuilder: (context, index) {
                                  final name = appointmentsList![index]["name"];
                                  final email =
                                  appointmentsList[index]["email"];
                                  final phone =
                                  appointmentsList[index]["phone"];
                                  final time = appointmentsList[index]['time'];
                                  final date = appointmentsList[index]['date'];
                                  final request =
                                  appointmentsList[index]['request'];
                                  final docID =
                                  appointmentsList[index]['docID'];

                                  return Column(
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.90,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.4), // Shadow color
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(
                                                  0, 3), // Shadow position
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(13.0),
                                        child: Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(Icons.person),
                                                    Text(
                                                      " $name",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 19.0),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 7.0),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.email_outlined),
                                                    Text(
                                                      " $email",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 19.0),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 7.0),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.phone),
                                                    Text(
                                                      " $phone",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 19.0),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 7.0),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.80,
                                                  child: Text(
                                                    request,
                                                    softWrap: true,
                                                    maxLines: 10,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                const SizedBox(height: 7.0),
                                                Text(
                                                  "Received on $date at $time",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Center(
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      await markAsDone(docID);
                                                    },
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                        Colors.green),
                                                    child: const Text(
                                                      "Done",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 19.0),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      await reject(docID);
                                                    },
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                        Colors.red),
                                                    child: const Text(
                                                      "Reject",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 19.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      "Past Appointments",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: FutureBuilder(
                          future: getPastAppointments(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                  'You have no upcoming appointments',
                                  style: TextStyle(color: Colors.white));
                            } else {
                              List<Map<String, dynamic>>? appointmentsList =
                              snapshot.data as List<Map<String, dynamic>>?;
                              return ListView.builder(
                                itemCount: appointmentsList?.length,
                                itemBuilder: (context, index) {
                                  final name = appointmentsList![index]["name"];
                                  final email =
                                  appointmentsList[index]["email"];
                                  final phone =
                                  appointmentsList[index]["phone"];
                                  final time = appointmentsList[index]['time'];
                                  final date = appointmentsList[index]['date'];
                                  final request =
                                  appointmentsList[index]['request'];

                                  return Column(
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.90,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.4), // Shadow color
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(
                                                  0, 3), // Shadow position
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(13.0),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(Icons.person),
                                                    Text(
                                                      " $name",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 19.0),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 7.0),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.email_outlined),
                                                    Text(
                                                      " $email",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 19.0),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 7.0),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.phone),
                                                    Text(
                                                      " $phone",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 19.0),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 7.0),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.80,
                                                  child: Text(
                                                    request,
                                                    softWrap: true,
                                                    maxLines: 10,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                const SizedBox(height: 7.0),
                                                Text(
                                                  "Received on $date at $time",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
  @override
  void dispose(){
    super.dispose();
  }
}

