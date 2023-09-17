//area
//category like
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/services/find_arbitrators.dart';
import 'districts.dart';
import 'find_notaries.dart';

class UserNotary extends StatefulWidget {
  const UserNotary({Key? key}) : super(key: key);

  @override
  State<UserNotary> createState() => _UserNotaryState();
}

class _UserNotaryState extends State<UserNotary> {
  List<String> indianStatesAndUTs = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    "Dadra and Nagar Haveli (UT)",
    "Daman and Diu (UT)",
    "Delhi (NCT)",
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
    'Delhi (National Capital Territory of Delhi)',
    'Puducherry (Pondicherry)'
  ];

  String selectedState = 'Select a State'; // Initial selected state
  String selectedDistrict = 'Select a District'; // Initial selected district

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: selectedState,
              onChanged: (String? newValue) {
                setState(() {
                  selectedState = newValue!;
                  // Reset selectedDistrict when the state changes
                  selectedDistrict = 'Select a District';
                });
              },
              items: [
                const DropdownMenuItem(
                  value: 'Select a State',
                  child: Text('Select a State'),
                ),
                ...indianStatesAndUTs.map<DropdownMenuItem<String>>((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 20.0),
            DropdownButton(
              value: selectedDistrict,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDistrict = newValue!;
                });
              },
              items: [
                const DropdownMenuItem(
                  value: 'Select a District',
                  child: Text('Select a District'),
                ),
                if (districtsMap.containsKey(selectedState))
                  ...districtsMap[selectedState.toString()]!.map((String district) {
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
              ],
            ),

            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotaryList(
                    state: selectedState,
                    district: selectedDistrict,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.brown,
              ),
              child: const Text(
                "Find me Arbitrators",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
