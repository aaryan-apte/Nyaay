import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LawyerList extends StatefulWidget {
  const LawyerList({super.key, required this.state, required this.district});

  final String state, district;

  @override
  State<LawyerList> createState() => _LawyerListState();
}

class _LawyerListState extends State<LawyerList> {
  late String state, district;
  @override
  initState() {
    super.initState();
    district = widget.district;
    state = widget.state;
  }

  Future<List<Map<String, dynamic>>> getLawyers() async {
    List<Map<String, dynamic>> lawyerList = [];

    try {
      print("district: $district");
      print("state: $state");

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
            .get();
      }

      for (var doc in querySnapshot.docs) {
        lawyerList.add({
          "name": doc['name'],
          "rating": doc['rating'],
          'experience': doc['experience'],
          'retainerFees': doc['retainerFees'],
          'hearingFees': doc['hearingFees'],
        });

        // print('Document ID: ${doc.id}');
        // print('State: ${doc['state']}');
        // print('District: ${doc['district']}');
        // Add your code to handle the documents here
      }
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
                  return const CircularProgressIndicator(
                    color: Colors.brown,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No lawyers found in Thane, Maharashtra.');
                } else {
                  // If data is available, display the list of lawyers
                  List<Map<String, dynamic>>? lawyerList = snapshot.data;
                  return ListView.builder(
                    itemCount: lawyerList?.length,
                    itemBuilder: (context, index) {
                      final name = lawyerList![index]["name"];
                      final experience = lawyerList[index]["experience"];
                      final rating = lawyerList[index]["rating"];
                      final retainerFees = lawyerList[index]['retainerFees'];
                      final hearingFees = lawyerList[index]['hearingFees'];
                      // print("Length: ${lawyerList.length}");

                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20.0)),
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              children: [
                                Text("Name: $name"),
                                Text("Experience: $experience Years"),
                                Text("Rating: $rating"),
                                Text("Hearing Fee: ₹$hearingFees"),
                                Text("Retainer Fee: ₹$retainerFees"),
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
