import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(this.lawyerEmail, {super.key});

  final String lawyerEmail;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late String lawyerEmail;

  @override
  initState() {
    super.initState();
    lawyerEmail = widget.lawyerEmail;
  }

  getAmount() async {
    final ref = await FirebaseFirestore.instance
        .collection('lawyer')
        .doc(lawyerEmail)
        .get();

    num amount = ref.data()!["hearingFees"];
    String lawyerName = ref.data()!['name'];
    // return {amount, lawyerName};
    Map<String, dynamic> map = {};
    map["amount"] = amount;
    map['lawyerName'] = lawyerName;
    return map;
    // map.add({"amount": amount, "lawyerName": lawyerName});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: FutureBuilder(
              future: getAmount(),
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
                  var requestList = snapshot.data as Map<String, dynamic>;
                  final lawyerName = requestList["lawyerName"];
                  final amount = requestList["amount"];


                  return Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.4),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Fees for ",style: TextStyle( fontSize: 20.0),
                            ),
                            Text("Adv. $lawyerName", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),)
                          ],
                        )
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: Text(
                          "Due amount: ₹$amount",
                          style: const TextStyle(fontSize: 22.0),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Image.asset('assets/images/paytm_logo.jpg'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child:
                                Image.asset('assets/images/phonepe_logo.png'),
                          ),
                        ],
                      )
                    ],
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
