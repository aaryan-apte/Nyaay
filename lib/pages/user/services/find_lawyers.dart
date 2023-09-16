import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/services/request_lawyer.dart';
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

  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 19.0);

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

                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20.0)),
                            padding: const EdgeInsets.all(13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                    Text("Weight: $leaderBoard",
                                        style: textStyle),
                                    Text("Categories: $category",
                                        style: textStyle),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserRequestLawyer(
                                          lawyerName: name,
                                          lawyerEmail: "aaryan3108@gmail.com",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text(
                                      "Request a talk",
                                      style: textStyle,
                                    ),
                                  ),
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
      ),
    );
  }
}
