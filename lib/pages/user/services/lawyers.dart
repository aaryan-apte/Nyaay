//area
//category like
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:nyaay/pages/user/home/drawer.dart';
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

 Widget getChild(String imagePath, String title) {
  return SizedBox(
    width: 80,
    height: 80,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Image.asset(
            imagePath, // Use the asset path instead of the network URL
            fit: BoxFit.cover,

          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle( fontSize: 10),),
        )
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: AppBar(
      // backgroundColor: Theme.of(context).colorScheme.secondary,// Customize the AppBar background color
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      elevation: 0, // Remove the shadow
      title: const Text(
        'Find Lawyers',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Customize the text color
        ),
      ),
      ),
      body: Container(
      //   decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/lawbg2.jpg'), // Replace with your image path
      //     fit: BoxFit.cover, // Adjust the fit as needed
      //   ),
      // ),
      
        child: Center(
            child: Container(
            //   decoration: const BoxDecoration(
            //   // color: Color.fromARGB(255, 9, 74, 127), // Background color for the rounded part
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(20.0), // Adjust the radius as needed
            //     topRight: Radius.circular(20.0), // Adjust the radius as needed
            //   ),
            // ),
            height: 730.0,
              child: Container(
                //  decoration: BoxDecoration(
                //       // color: Colors.white, // Background color
                //       borderRadius: BorderRadius.circular(16.0), // Rounded corners
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.4), // Shadow color
                //           spreadRadius: 3,
                //           blurRadius: 7,
                //           offset: const Offset(0, 3), // Shadow position
                //         ),
                //       ],
                //     ),
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                      
                    Container(
                     decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(16.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), // Shadow color
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        
                        children: [
                          Container(
                            
                            child: const Text(
                              'Select the Area', // Your text content
                              style: TextStyle(
                                fontSize: 18.0, // Adjust the font size
                                fontWeight: FontWeight.bold, // Adjust the font weight
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontStyle: FontStyle.normal,// Adjust the text color
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
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
                      ],
                      ),
                    ),
                    
                    Container(
                      
                      child: const Column(
                        children: [
                          Text(
                          'Select Case Type', // Your text content
                          style: TextStyle(
                            fontSize: 18.0, // Adjust the font size
                            fontWeight: FontWeight.bold, // Adjust the font weight
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontStyle: FontStyle.normal,// Adjust the text color
                          ),
                          textAlign: TextAlign.left,
                        ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      
                      child: MultiSelectContainer(
                        itemsPadding: const EdgeInsets.all(10),
                        itemsDecoration: const MultiSelectDecorations(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          selectedDecoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(131, 0, 0, 0),
                              Color.fromARGB(255, 255, 251, 251)
                            ]),  
                            
                          ),
                        ),
                        controller: _controller,
                        maxSelectableCount: 1,
                        items: [
                          MultiSelectCard(
                            value: 'Civil', 
                            // label: '',
                            child: getChild(
                            'assets/images/lawyer.png',
                            'Civil'),),
                          MultiSelectCard(
                            value: 'Corporate', 
                            child: getChild(
                            'assets/images/lawyer.png',
                            'Corporate'),),
                          MultiSelectCard(
                            value: 'Criminal', 
                           child: getChild(
                            'assets/images/lawyer.png',
                            'Criminal'),),
                          MultiSelectCard(
                            value: 'Debt', 
                            child: getChild(
                            'assets/images/lawyer.png',
                            'Debt'),),
                          MultiSelectCard(
                            value: 'Family', 
                            child: getChild(
                            'assets/images/lawyer.png',
                            'Family'),),
                            MultiSelectCard(
                            value: 'Insurance', 
                            child: getChild(
                            'assets/images/lawyer.png',
                            'Insurance'),),
                            MultiSelectCard(
                            value: 'Property', 
                            child: getChild(
                            'assets/images/lawyer.png',
                            'Property'),),
                            MultiSelectCard(
                            value: 'Others', 
                            child: getChild(
                            'assets/images/lawyer.png',
                            'Others'),),
                        ],
                        onChange: (List<String> selectedItems, String? selectedItem) {
                          selectedCategory = _controller.getSelectedItems();
                        },
                        
                      ),
                    ),
                    const SizedBox(height: 30.0),
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
                        backgroundColor: Color.fromARGB(31, 0, 0, 0),
                      ),
                      child: const Text(
                        "Find me Lawyers",
                        style: TextStyle(color: Color.fromARGB(255, 4, 4, 4), fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
