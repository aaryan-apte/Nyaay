import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:nyaay/pages/user/services/request_lawyer.dart';
import 'package:nyaay/pages/user/services/lawyer_detail_page.dart';
import 'package:nyaay/pages/user/home/drawer.dart';
import 'dart:math';

class LawyerList extends StatefulWidget {
  const LawyerList(
      {super.key,
      required this.state,
      required this.district,
      required this.category});

  final String state, district, category;

  @override
  State<LawyerList> createState() => _LawyerListState();
}

class _LawyerListState extends State<LawyerList> {
  late String state, district, category;
  @override
  initState() {
    super.initState();
    district = widget.district;
    state = widget.state;
    category = widget.category;
  }

  TextStyle textStyle =
      const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15.0);

  Future<List<Map<String, dynamic>>> getLawyers() async {
    List<Map<String, dynamic>> lawyerList = [];

    try {
      QuerySnapshot querySnapshot;

      if (district == "Select a District") {
        querySnapshot = await FirebaseFirestore.instance
            .collection('lawyer')
            .where('state', isEqualTo: state)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('lawyer')
            .where('state', isEqualTo: state)
            .where('district', isEqualTo: district)
            // .where('hearingFees', isGreaterThanOrEqualTo: 12000)
            .get();
      }

      for (var doc in querySnapshot.docs) {
        for (var cat in doc['categories']) {
          if (cat == category) {
            lawyerList.add({
              "name": doc['name'],
              "rating": doc['rating'],
              'experience': doc['experience'],
              'retainerFees': doc['retainerFees'],
              'hearingFees': doc['hearingFees'],
              'cases': doc['cases'],
              'leaderBoard': pow(doc['cases'], 0.4) * pow(doc['rating'], 0.6),
              'categories': doc['categories'],
              'docID': doc.id,
              'description': doc['description'],
              'courts':doc['courts'],
            });
          }
        }
      }

      lawyerList.sort((a, b) => b['leaderBoard'].compareTo(a['leaderBoard']));

      // print('Document ID: ${doc.id}');
      // print('State: ${doc['state']}');
      // print('District: ${doc['district']}');
      // Add your code to handle the documents here

    } catch (e) {
      throw ('Error fetching lawyers: $e');
    }
    return lawyerList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.secondary,// Customize the AppBar background color
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0, // Remove the shadow
        toolbarHeight: 100,
        title: Row(
          children: [
            const Text(
              'Find Lawyers    ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            // SizedBox(height: 100.0),
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the content vertically
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 15.0, // Adjust the icon size as needed
                      ),
                      Text(
                        '$district, $state',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3.0),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.work_outline,
                        color: Colors.white,
                        size: 15.0, // Adjust the icon size as needed
                      ),
                      Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: FutureBuilder(
              future: getLawyers(),
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
                  return Text('No lawyers found in $district, $state.',
                      style: const TextStyle(color: Colors.red));
                } else {
                  List<Map<String, dynamic>>? lawyerList = snapshot.data;
                  return ListView.builder(
                    itemCount: lawyerList?.length,
                    itemBuilder: (context, index) {
                      final name = lawyerList![index]["name"];
                      final experience = lawyerList[index]["experience"];
                      final rating = lawyerList[index]["rating"];
                      final retainerFees = lawyerList[index]['retainerFees'];
                      final hearingFees = lawyerList[index]['hearingFees'];
                      final docID = lawyerList[index]["docID"];
                      final description = lawyerList[index]["description"];
                      final courts = lawyerList[index]["courts"];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LawyerDetailPage(
                                description: description,
                                courts: courts,
                                lawyerName: name,
                                lawyerEmail: docID,
                                state: state,
                                district: district,
                                rating: rating.toString(),
                                  retainerFees: retainerFees.toString(),
                                hearingFees: hearingFees.toString(),
                                experience: experience.toString(),
                                // lawyerRating: rating,
                                // hearingFees: hearingFees,
                                // retainerFees: retainerFees,
                                // leaderBoard: leaderBoard,
                                // categories: categories,
                              ),
                            ),
                          );
                          print(docID);
                        },
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
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 125,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/aaryan_photo2.jpg'), // Replace with your image path
                                        fit: BoxFit
                                            .cover, // Adjust the fit as needed
                                      ),
                                    ),
                                    margin: const EdgeInsetsDirectional.only(
                                        end: 8),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19.0),
                                      ),
                                      Text(
                                        "Experience: $experience Years",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19.0),
                                      ),
                                      Text(
                                        "⭐ $rating",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19.0),
                                      ),
                                      Text(
                                        "Hearing Fee: ₹$hearingFees",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 19.0),
                                      ),
                                      Text(
                                        "Retainer Fee: ₹$retainerFees",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 19.0),
                                      ),
                                      // const SizedBox(height: 10),
                                      // Text("Weight: $leaderBoard",
                                      //     style: textStyle),
                                      // Text("Categories: $category",
                                      //     style: textStyle),
                                      //     TextButton(
                                      //     onPressed: () {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) => UserRequestLawyer(
                                      //           lawyerName: name,
                                      //           lawyerEmail: "aaryan3108@gmail.com",
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      //   child: Container(
                                      //     padding: const EdgeInsets.all(10.0),
                                      //     decoration: BoxDecoration(
                                      //         color: const Color.fromARGB(255, 197, 197, 197),
                                      //         borderRadius:
                                      //             BorderRadius.circular(10.0)),
                                      //     child: Text(
                                      //       "Request a talk",
                                      //       style: textStyle,
                                      //     ),
                                      //   ),
                                      //  )
                                    ],
                                  ),
                                  // TextButton(
                                  //   onPressed: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => UserRequestLawyer(
                                  //           lawyerName: name,
                                  //           lawyerEmail: "aaryan3108@gmail.com",
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: Container(
                                  //     padding: const EdgeInsets.all(10.0),
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.blue,
                                  //         borderRadius:
                                  //             BorderRadius.circular(10.0)),
                                  //     child: Text(
                                  //       "Request a talk",
                                  //       style: textStyle,
                                  //     ),
                                  //   ),
                                  // )
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
