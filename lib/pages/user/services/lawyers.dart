//area
//category like
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'districts.dart';
import 'find_lawyers.dart';

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

  final MultiSelectController<String> _controller =
      MultiSelectController(deSelectPerpetualSelectedItems: true);

  List<String> selectedCategory = [];

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
                  selectedDistrict = 'Select a District';
                });
              },
              items: [
                const DropdownMenuItem(
                  value: 'Select a State',
                  child: Text('Select a State'),
                ),
                ...indianStatesAndUTs
                    .map<DropdownMenuItem<String>>((String state) {
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
                  ...districtsMap[selectedState.toString()]!
                      .map((String district) {
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
              ],
            ),
            const SizedBox(height: 40.0),
            MultiSelectContainer(
              controller: _controller,
              maxSelectableCount: 1,
              items: [
                MultiSelectCard(value: 'Criminal', label: 'Criminal'),
                MultiSelectCard(value: 'Land', label: 'Land'),
                MultiSelectCard(value: 'Family', label: 'Family'),
                MultiSelectCard(value: 'Civil', label: 'Civil'),
                MultiSelectCard(value: 'Corporate', label: 'Corporate'),
              ],
              onChange: (List<String> selectedItems, String? selectedItem) {
                selectedCategory = _controller.getSelectedItems();
              },
            ),
            const SizedBox(height: 40.0),
            TextButton(
              onPressed: () {
                if (selectedCategory.isEmpty) {
                  // Show a SnackBar if no category is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Select at least one category",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LawyerList(
                        state: selectedState,
                        district: selectedDistrict,
                        category: selectedCategory[0],
                      ),
                    ),
                  );
                  // print(selectedCategory);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.brown,
              ),
              child: const Text(
                "Find me Lawyers",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
