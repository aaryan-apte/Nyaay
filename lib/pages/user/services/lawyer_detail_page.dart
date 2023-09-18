//ignore_for_file: ignore_const_preferences
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/home/drawer.dart';
import 'package:nyaay/pages/user/services/request_lawyer.dart';

class LawyerDetailPage extends StatefulWidget {
  LawyerDetailPage (
      {super.key, 
      required this.lawyerName, 
      required this.lawyerEmail,
      // required this.lawyerRating,
      // required this.hearingFees,
      // required this.retainerFees,
      // required this.categories,
      // required this.leaderBoard,
      });

  String lawyerName, lawyerEmail;
  // lawyerRating, categories;
  // double hearingFees, retainerFees, leaderBoard;

  @override
  State<LawyerDetailPage> createState() => _LawyerDetailPageState();
}

class _LawyerDetailPageState extends State<LawyerDetailPage> {
  late String lawyerName, lawyerEmail;
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
    // lawyerRating = widget.lawyerRating;
    // hearingFees = widget.hearingFees;
    // retainerFees = widget.retainerFees;
    // categories = widget.categories;
    // leaderBoard = widget.leaderBoard;
  }

  sendRequest() async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    // print(userEmail);
    final refL = FirebaseFirestore.instance
        .collection('lawyer')
        .doc('aaryan3108@gmail.com') // lawyerEmail
        .collection('requests');

    final refU = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('requests');
  }

    

  @override
  Widget build(BuildContext context) {
    // final levelIndicator = Container(
    //   child: Container(
    //     child: LinearProgressIndicator(
    //         backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
    //         value: double.parse(lawyerRating),
    //         valueColor: AlwaysStoppedAnimation(Colors.green)),
    //   ),
    // );

    final lawyerPrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        "\Rs 10000",
        style: TextStyle(color: Colors.white),
      ),
    );

    
    final readButton = Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(140, 142, 142, 142), // Set your desired background color here
        ),
        onPressed: () => {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserRequestLawyer(
                    lawyerName: lawyerName,
                    lawyerEmail: "aaryan3108@gmail.com",
                  ),
                ),
              )
        },
        child: const Row(
          children: [
            Icon(
              Icons.call,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(height: 8.0),
            Text("Request A Call", style: TextStyle(
              color: Color.fromARGB(255, 19, 19, 19),
              fontWeight: FontWeight.bold,
            )
              ),
          ],
        ),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 190.0),
        // const Icon(
        //   Icons.directions_car,
        //   color: Colors.white,
        //   size: 40.0,
        // ),
        Container(
          width: 90.0,
          child: const Divider(color: Colors.green),
        ),
        SizedBox(height: 5.0),
        Text(
          lawyerName,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        // SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Expanded(flex: 1, child: levelIndicator),
             const Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 3.0),
                    child: Row(
                      children: [
                        Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20.0, // Adjust the icon size as needed
                      ),
                        Text(
                          ' Maharashtra, Thane',
                          style: TextStyle(color: Colors.white),
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
                        size: 20.0, // Adjust the icon size as needed
                      ),
                        Text(
                          ' 6 years Experience',
                          style: TextStyle(color: Colors.white),
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
        
      ],
      
    );
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              image: const DecorationImage(
                image: const AssetImage('assets/images/adv2.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0), // Adjust the radius as needed
                        bottomRight: Radius.circular(20.0), // Adjust the radius as needed
                      ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
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
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

   final bottomContentText = Column(
     mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
    crossAxisAlignment: CrossAxisAlignment.start,
     children: [
      Text(
        'Advocate Sudershani has since been practicing and handling cases independently with a result oriented approach, both professionally and ethically and has now acquired 8 years of professional experience in providing legal consultancy and advisory services. She has completed her BA.LLB(Hons) from Jamia Millia Islamia and has been practicing and handling cases independently and provides legal consultancy and advisory services.',
        style: TextStyle(fontSize: 15.0, ),
      ),
      SizedBox(height: 20.0),
      Text(
        'Practice Areas',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      ),
      Text(
        'Anticipatory Bail, Cheque Bounce, Child Custody, Court Marriage, Divorce, Domestic Violence, Family, High Court, Recovery, Succession Certificate, Wills / Trusts',
        style: TextStyle(fontSize: 15.0),
      ),
      SizedBox(height: 20.0),
      Text(
        'Courts',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      ),
      Text(
        'Bombay High Court, City Civil Court, Mumbai, Consumer District Forum, Mumbai, Court of Small Causes, Mumbai, Debts Recovery Tribunal (DRT) Mumbai, District and Sessions Court, Mumbai, District Court, Mumbai, Family Courts, Mumbai, State Consumer Disputes Redressal Commission, UP, Trial Courts, Mumbai',
        style: TextStyle(fontSize: 15.0),
      ),
      SizedBox(height: 20.0),
      Text(
        'Testimonial/Reviews',
        style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w600),
      ),
     ],
   );


final bottomContent = Container(
  
  width: MediaQuery.of(context).size.width,
  padding: EdgeInsets.all(40.0),
  child: Center(
    child: Column(
      children: <Widget>[bottomContentText],
    ),
  ),
);

return SafeArea(
  child: Scaffold(
    body: Column(
      children: <Widget>[
        topContent,
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(), // Adjust the physics as needed
            child: Padding(
              padding: EdgeInsets.only(top: 15.0), // Define your top limit
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

