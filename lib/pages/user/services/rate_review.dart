//ignore_for_file: ignore_const_preferences
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nyaay/pages/user/home/drawer.dart';

class RateReview extends StatefulWidget {
  RateReview(
      {super.key, required this.lawyerName, required this.lawyerEmail, required this.uname });

  String lawyerName, lawyerEmail, uname;

  @override
  State<RateReview> createState() => _RateReviewState();
}

class _RateReviewState extends State<RateReview> {
  late String lawyerName, lawyerEmail, uname;

  
  TextEditingController requestController = TextEditingController();
  
  double rating = 0.0; 

  @override
  void initState() {
    super.initState();
    lawyerEmail = widget.lawyerEmail;
    lawyerName = widget.lawyerName;
    uname = widget.uname;
  }

  Future<void> sendReview(double rating) async {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  final refL = FirebaseFirestore.instance
      .collection('lawyer')
      .doc('aaryan3108@gmail.com') // lawyerEmail
      .collection('testimonials');

  try {
    await refL.add({
      "review": requestController.text.trim(),
      "date": "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
      "time": "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      "name": uname,
      "rating": rating, // Add the rating to the Firestore document
    });

    // Optionally, you can print a success message here or perform other actions.
    print('Review added successfully with rating: $rating');
  } catch (e) {
    // Handle errors gracefully, e.g., display a Snackbar with the error message.
    print('Error adding review: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        drawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.secondary,// Customize the AppBar background color
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0, // Remove the shadow
        toolbarHeight: 100,
        title: const Text(
          'Rate & Review Lawyer',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
        body: Container(
           decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage('assets/images/lawbg2.jpg'), // Replace with your image path
                    //   fit: BoxFit.cover, // Adjust the fit as needed
                    // ),
                  ),
          // color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                
                  margin: const EdgeInsets.only(
                      top: 1.0, left: 11.0, right: 11.0, bottom: 54.0),
                  child: Container(
                    //  decoration: BoxDecoration(
                    //   // color: Colors.white, // Background color
                    //   borderRadius: BorderRadius.circular(16.0), // Rounded corners
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.3), // Shadow color
                    //       spreadRadius: 3,
                    //       blurRadius: 5,
                    //       offset: const Offset(0, 3), // Shadow position
                    //     ),
                    //   ],
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Review by $uname",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20.0,
                                        // fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w200),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "for Adv. $lawyerName",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15.0,
                                        // fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                
                                child: RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (newRating) {
                                    setState(() {
                                        rating = newRating;
                                    });
                                    print(newRating);
                                  },
                                )

                              ),
                              const SizedBox(height: 20.0),
                              
                              
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: TextField(
                                  maxLines: 7,
                                  controller: requestController,
                                  decoration: const InputDecoration(
                                      hintText: "Write Review",
                                      hintStyle:
                                          TextStyle(color: Color.fromARGB(97, 0, 0, 0))),
                                  // keyboardType: TextInputType,
                                  cursorColor: Color.fromARGB(255, 137, 135, 135),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 18, 18, 18), fontSize: 18.0),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              TextButton(
                                onPressed: () {
                                  sendReview(rating);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Upload",
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
