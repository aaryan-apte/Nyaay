import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/services/request_lawyer.dart';
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

  TextStyle textStyle = const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15.0);

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

          if(cat == category) {
            lawyerList.add({
              "name": doc['name'],
              "rating": doc['rating'],
              'experience': doc['experience'],
              'retainerFees': doc['retainerFees'],
              'hearingFees': doc['hearingFees'],
              'cases': doc['cases'],
              'leaderBoard': pow(doc['cases'], 0.4) * pow(doc['rating'], 0.6),
              'categories' : doc['categories'],
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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      elevation: 0,// Remove the shadow
      toolbarHeight: 100,
      title: const Row(
        children: [
          Text(
            'Find Lawyers    ',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          // SizedBox(height: 100.0),
          Column(
             mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Row(
                          children: [
                            Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 15.0, // Adjust the icon size as needed
                          ),
                            Text(
                              ' Maharashtra, Thane',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Row(
                          children: [
                             Icon(
                            Icons.work_outline,
                            color: Colors.white,
                            size: 15.0, // Adjust the icon size as needed
                          ),
                            Text(
                              ' Family',
                              style: TextStyle(color: Colors.white, fontSize: 10),
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
                  return const Text('No lawyers found in Thane, Maharashtra.',
                      style: TextStyle(color: Colors.red));
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
                      final leaderBoard = lawyerList[index]['leaderBoard'];
                      final categories = lawyerList[index]['categories'];
                      // print("Length: ${lawyerList.length}");
        
                      return GestureDetector
                      (
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LawyerDetailPage(
                                  lawyerName: name,
                                  lawyerEmail: "aaryan3108@gmail.com",
                                  // lawyerRating: rating,
                                  // hearingFees: hearingFees,
                                  // retainerFees: retainerFees,
                                  // leaderBoard: leaderBoard,
                                  // categories: categories,
                                ),
                              ),
                            );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4), // Shadow color
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // Shadow position
                                    ),
                                  ],
                                  ),
                                  
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height:125,
                                    width:100,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/adv2.jpeg'), // Replace with your image path
                                        fit: BoxFit.cover, // Adjust the fit as needed
                                      ),
                                    ),
                                    margin: const EdgeInsetsDirectional.only(end: 8),
                                   ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name: $name", style: textStyle),
                                      Text("Experience: $experience Years",
                                          style: textStyle),
                                      Text("Rating: $rating", style: textStyle),
                                      Text("Hearing Fee: ₹$hearingFees",
                                          style: textStyle),
                                      Text("Retainer Fee: ₹$retainerFees",
                                          style: textStyle),
                                      // const SizedBox(height: 10),
                                      // Text("Weight: $leaderBoard",
                                      //     style: textStyle),
                                      Text("Categories: $category",
                                          style: textStyle),
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
