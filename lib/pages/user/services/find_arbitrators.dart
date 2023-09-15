import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArbitratorList extends StatefulWidget {
  const ArbitratorList({super.key, required this.state, required this.district});

  final String state, district;

  @override
  State<ArbitratorList> createState() => _ArbitratorListState();
}

class _ArbitratorListState extends State<ArbitratorList> {
  late String state, district;
  @override
  initState() {
    super.initState();
    district = widget.district;
    state = widget.state;
  }

  Future<List<Map<String, dynamic>>> getArbitrators() async {
    List<Map<String, dynamic>> arbitratorList = [];

    try {
      print("district: $district");
      print("state: $state");

      QuerySnapshot querySnapshot;

      if (district == "Select a District") {
        querySnapshot = await FirebaseFirestore.instance
            .collection('arbitrator')
            .where('state', isEqualTo: state)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('arbitrator')
            .where('state', isEqualTo: state)
            .where('district', isEqualTo: district)
            .get();
      }

      for (var doc in querySnapshot.docs) {
        arbitratorList.add({
          "name": doc['name'],
          "rating": doc['rating'],
          'experience': doc['experience'],
          'fee': doc['fee'],
        });

        // print('Document ID: ${doc.id}');
        // print('State: ${doc['state']}');
        // print('District: ${doc['district']}');
        // Add your code to handle the documents here
      }
    } catch (e) {
      throw ('Error fetching arbitrators: $e');
    }
    return arbitratorList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: FutureBuilder(
              future: getArbitrators(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.brown,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No arbitrators found in Thane, Maharashtra.');
                } else {
                  // If data is available, display the list of arbitrators
                  List<Map<String, dynamic>>? arbitratorList = snapshot.data;
                  return ListView.builder(
                    itemCount: arbitratorList?.length,
                    itemBuilder: (context, index) {
                      final name = arbitratorList![index]["name"];
                      final experience = arbitratorList[index]["experience"];
                      final rating = arbitratorList[index]["rating"];
                      final fee = arbitratorList[index]['fee'];
                      // print("Length: ${arbitratorList.length}");

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
                                Text("Fee: ₹$fee"),
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
