// import 'package:cached_network_image/cached_network_image.dart';

// ignore_for_file: prefer_const_constructors
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nyaay/pages/user/services/arbitrators.dart';
import 'package:nyaay/pages/user/services/lawyers.dart';
// import 'package:nyaay/localizations.dart';

import '../services/mediators.dart';
import '../services/notaries.dart';
import 'drawer.dart';
import 'slider.dart';

class HomeU extends StatefulWidget {
  const HomeU({super.key});

  @override
  _HomeUState createState() => _HomeUState();
}

class _HomeUState extends State<HomeU> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: AppBar(
        // Provide a standard title.
        // title: Text('asdas'),
        // pinned: true,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     onPressed: () {},
        //   )
        // ],
        // Allows the user to reveal the app bar if they begin scrolling
        // back up the list of items.
        // floating: true,
        // Display a placeholder widget to visualize the shrinking size.
        
        flexibleSpace: HomeSlider(),
        // Make the initial height of the SliverAppBar larger than normal.
        toolbarHeight: 465,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            
            Container(
              // color: Colors.black.withOpacity(0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                    child: Center(
                      child: Text(('LEGAL PROVIDERS'),
                          style: TextStyle(
                              color: Color.fromARGB(123, 21, 21, 21),
                              fontSize: 15,
                              fontWeight: FontWeight.w200)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    height: 170.0,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      SizedBox(
                        width: 140.0,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            // onTap: () {
                            //   Navigator.pushNamed(
                            //       context, '/products',
                            //       arguments: i);
                            // },
                            child: Container(

                              child: GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 60,
                                      child: Image(
                                        // fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/lawyer.png'),
                                        // placeholder: (context, url) =>
                                        //     Center(
                                        //         child:
                                        //             CircularProgressIndicator()),
                                        // errorWidget:
                                        //     (context, url, error) =>
                                        //         new Icon(Icons.error),
                                      ),
                                    ),
                                    ListTile(
                                      title: Center(
                                        child: Text(
                                          'Lawyer',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserLawyer()));
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserNotary())),
                          child: SizedBox(
                            width: 140.0,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                // onTap: () {
                                //   Navigator.pushNamed(
                                //       context, '/products',
                                //       arguments: i);
                                // },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 60,
                                      child: Image(
                                        // fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/document.png'),
                                        // placeholder: (context, url) =>
                                        //     Center(
                                        //         child:
                                        //             CircularProgressIndicator()),
                                        // errorWidget:
                                        //     (context, url, error) =>
                                        //         new Icon(Icons.error),
                                      ),
                                    ),
                                    ListTile(
                                      title: Center(
                                        child: Text(
                                          'Notary',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserMediator())),
                          child: SizedBox(
                            width: 140.0,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                // onTap: () {
                                //   Navigator.pushNamed(
                                //       context, '/products',
                                //       arguments: i);
                                // },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 60,
                                      child: Image(
                                        // fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/intermediary.png'),
                                        // placeholder: (context, url) =>
                                        //     Center(
                                        //         child:
                                        //             CircularProgressIndicator()),
                                        // errorWidget:
                                        //     (context, url, error) =>
                                        //         new Icon(Icons.error),
                                      ),
                                    ),
                                    ListTile(
                                      title: Center(
                                        child: Text(
                                          'Mediator',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserArbitrator())),
                          child: SizedBox(
                            width: 140.0,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                // onTap: () {
                                //   Navigator.pushNamed(
                                //       context, '/products',
                                //       arguments: i);
                                // },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 60,
                                      child: Image(
                                        // fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/agreement.png'),
                                        // placeholder: (context, url) =>
                                        //     Center(
                                        //         child:
                                        //             CircularProgressIndicator()),
                                        // errorWidget:
                                        //     (context, url, error) =>
                                        //         new Icon(Icons.error),
                                      ),
                                    ),
                                    ListTile(
                                      title: Center(
                                        child: Text(
                                          'Arbitrator',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  // Container(
                  //   child: const Padding(
                  //     padding:
                  //         EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
                  //     child: Image(
                  //       fit: BoxFit.cover,
                  //       image: AssetImage('assets/images/banner-1.png'),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 176, 176, 176).withOpacity(0.5), // Shadow color
                              spreadRadius: 3, // Spread radius
                              blurRadius: 7, // Blur radius
                              offset: Offset(0, 3), // Offset in x and y directions
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: const Text('View Appointments',
                              style:
                                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/categorise');
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
