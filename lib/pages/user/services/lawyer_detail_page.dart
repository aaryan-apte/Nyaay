//ignore_for_file: ignore_const_preferences
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:nyaay/pages/user/home/drawer.dart';
import 'package:nyaay/pages/user/services/request_lawyer.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 10.0,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index + 1 <= rating) {
          return Icon(
            Icons.star,
            size: size,
            color: color,
          );
        } else if (index < rating) {
          return Icon(
            Icons.star_half,
            size: size,
            color: color,
          );
        } else {
          return Icon(
            Icons.star_border,
            size: size,
            color: color,
          );
        }
      }),
    );
  }
}

class LawyerDetailPage extends StatefulWidget {
  LawyerDetailPage({
    super.key,
    required this.lawyerName,
    required this.lawyerEmail,
    required this.district,
    required this.state,
    required this.rating,
    required this.retainerFees,
    required this.hearingFees,
    required this.experience,
    required this.description,
    required this.courts,
    // required this.lawyerRating,
    // required this.hearingFees,
    // required this.retainerFees,
    // required this.categories,
    // required this.leaderBoard,
  });

  String lawyerName,
      lawyerEmail,
      state,
      district,
      hearingFees,
      retainerFees,
      rating,
      description,
      courts,
      experience;
  // lawyerRating, categories;
  // double hearingFees, retainerFees, leaderBoard;

  @override
  State<LawyerDetailPage> createState() => _LawyerDetailPageState();
}

class _LawyerDetailPageState extends State<LawyerDetailPage> {
  late String lawyerName,
      lawyerEmail,
      state,
      district,
      hearingFees,
      retainerFees,
      courts,
      description,
      rating,
      experience;
  // lawyerRating, categories;
  // double hearingFees, retainerFees, leaderBoard;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lawyerEmail = widget.lawyerEmail;
    lawyerName = widget.lawyerName;
    state = widget.state;
    district = widget.district;
    hearingFees = widget.hearingFees;
    retainerFees = widget.retainerFees;
    rating = widget.rating;
    experience = widget.experience;
    courts = widget.courts;
    description = widget.description;
  }

  getTestimonials() async {
    // final email = FirebaseAuth.instance.currentUser?.email;
    final ref = await FirebaseFirestore.instance
        .collection('lawyer')
        .doc(lawyerEmail)
        .collection('testimonials')
        .get();

    List<Map<String, dynamic>> map = [];
    for (var doc in ref.docs) {
      map.add({
        "name": doc['name'],
        "review": doc['review'],
        "date": doc['date'],
        "rating": doc['rating'],
      });
    }
    return map;
  }

  // sendRequest() async {
  //   String? userEmail = FirebaseAuth.instance.currentUser?.email;
  //   // print(userEmail);
  //   final refL = FirebaseFirestore.instance
  //       .collection('lawyer')
  //       .doc('aaryan3108@gmail.com') // lawyerEmail
  //       .collection('requests');
  //
  //   final refU = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userEmail)
  //       .collection('requests');
  // }

  @override
  Widget build(BuildContext context) {
    final readButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(
              140, 142, 142, 142), // Set your desired background color here
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserRequestLawyer(
                lawyerName: lawyerName,
                lawyerEmail: lawyerEmail,
              ),
            ),
          )
        },
        child: Row(
          children: const [
            Icon(
              Icons.call,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(height: 8.0),
            Text(
              "Request A Call",
              style: TextStyle(
                color: Color.fromARGB(255, 19, 19, 19),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 170.0),
        // const Icon(
        //   Icons.directions_car,
        //   color: Colors.white,
        //   size: 40.0,
        // ),
        const SizedBox(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        const SizedBox(height: 5.0),
        Text(
          lawyerName,
          style: const TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        // SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Expanded(flex: 1, child: levelIndicator),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20.0, // Adjust the icon size as needed
                        ),
                        Text(
                          '$district, $state',
                          style: const TextStyle(color: Colors.white),
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
                          size: 20.0, // Adjust the icon size as needed
                        ),
                        Text(
                          ' $experience years Experience',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(flex: 1, child: lawyerPrice),
            Expanded(flex: 2, child: readButton),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.payment,
                    color: Colors.white,
                    size: 20.0, // Adjust the icon size as needed
                  ),
                  Text(
                    'Retainer Fee: ₹$retainerFees   ',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                children: [
                  Text(
                    'Hearing Fee: ₹$hearingFees',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
    final topContent = Stack(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 20.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/aaryan_photo2.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(20.0), // Adjust the radius as needed
                bottomRight:
                    Radius.circular(20.0), // Adjust the radius as needed
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(58, 66, 86, 0.481),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // Adjust the radius as needed
              bottomRight: Radius.circular(20.0), // Adjust the radius as needed
            ),
          ),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Column(
      // mainAxisAlignment:
      // MainAxisAlignment.start, // Center the content vertically
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About $lawyerName',
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 15.0),
        ),
        // const SizedBox(height: 20.0),
        // const Text(
        //   'Practice Areas',
        //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        // ),
        const SizedBox(height: 20.0),
        const Text(
          'Courts',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        Text(
          courts,
          style: const TextStyle(fontSize: 15.0),
        ),
        const SizedBox(height: 20.0),
        const Text(
          'Testimonial/Reviews',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: FutureBuilder(
            future: getTestimonials(),
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
                return Text('No testimonial found for $lawyerName',
                    style: const TextStyle(color: Colors.red));
              } else {
                List<Map<String, dynamic>>? testimonialList =
                    snapshot.data as List<Map<String, dynamic>>?;
                return ListView.builder(
                  itemCount: testimonialList?.length,
                  itemBuilder: (context, index) {
                    final name = testimonialList![index]["name"];
                    final review = testimonialList[index]["review"];
                    final date = testimonialList[index]["date"];
                    final rating = testimonialList[index]["rating"];

                    return Column(
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
                                offset: const Offset(0, 3), // Shadow position
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.account_box_sharp,
                                        color: Color.fromARGB(255, 12, 12, 12),
                                        size: 20.0,
                                      ),
                                      Text(
                                        name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                  StarRating(
                                    rating: rating
                                        .toDouble(), // Assuming rating is a double value
                                    size: 20.0, // Adjust the size as needed
                                    color: Colors
                                        .amber, // Choose the color you want for stars
                                  ),
                                  Text(
                                    "Review uploaded on: $date",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width: 280,
                                      child: Text(
                                        "$review",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w100,
                                            fontSize: 13.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
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
      ],
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: [bottomContentText],
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            topContent,
            Expanded(
              child: SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(), // Adjust the physics as needed
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0), // Define your top limit
                  child: bottomContent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
