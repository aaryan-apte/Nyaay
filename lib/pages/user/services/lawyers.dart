//area
//category like
import 'package:flutter/material.dart';
import 'districts.dart';

class UserLawyer extends StatefulWidget {
  const UserLawyer({Key? key}) : super(key: key);

  @override
  State<UserLawyer> createState() => _UserLawyerState();
}

class _UserLawyerState extends State<UserLawyer> {


  List<String> indianStatesAndUTs = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
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

  String selectedState = 'Maharashtra'; // Initial selected stat
  String selectedDistrict = 'Mumbai City'; // Initial selected stat

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
                });
              },
              items: <DropdownMenuItem<String>>[
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
                DropdownMenuItem(
                  value: 'Select a District',
                  child: Text('Select a District'),
                ),
                if (districtsMap.containsKey(selectedState))
                  ...districtsMap[selectedState.toString()]!.map((String district) {
                    setState(() {
                      selectedDistrict = district;
                    });
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
              ],
            )


          ],
        ),
      ),
    );
  }
}
