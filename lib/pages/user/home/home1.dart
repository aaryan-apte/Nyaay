import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:nyaay/localizations.dart';

import 'drawer.dart';
import 'slider.dart';

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final List<String> imgList = [
    // 'https://i.pinimg.com/564x/4b/b7/b4/4bb7b4aecb1ac4cdfe53600992f455f3.jpg',
    // 'https://in.pinterest.com/pin/596586281913615172/',
    // 'https://i.pinimg.com/564x/4b/b7/b4/4bb7b4aecb1ac4cdfe53600992f455f3.jpg',
    // 'https://i.pinimg.com/564x/4b/b7/b4/4bb7b4aecb1ac4cdfe53600992f455f3.jpg',
    // 'https://i.pinimg.com/564x/4b/b7/b4/4bb7b4aecb1ac4cdfe53600992f455f3.jpg',
    // 'https://i.pinimg.com/564x/4b/b7/b4/4bb7b4aecb1ac4cdfe53600992f455f3.jpg',
    // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
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
               toolbarHeight: 475,
              ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Stack(
          children: <Widget>[
            
          // Background image
          Positioned.fill(
             top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/lawbg1.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
           Container(
            color: Colors.black.withOpacity(0.9),
            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding:
                                const EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                            child: Center(
                              child: Text(
                                  ('LEGAL PROVIDERS'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            height: 170.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget> [
                                Container(
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
                                            children: <Widget>[
                                              SizedBox(
                                              
                                                height: 60,
                                                child: Container(
                                                  // tag: '$i',
                                                  child: const Image(
                                                    // fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/lawyer.png'),
                                                    // placeholder: (context, url) =>
                                                    //     Center(
                                                    //         child:
                                                    //             CircularProgressIndicator()),
                                                    // errorWidget:
                                                    //     (context, url, error) =>
                                                    //         new Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              const ListTile(
                                                title: Center(
                                                  child: Text(
                                                    'Lawyer',
                                                    style: TextStyle(fontSize: 22),
                                                    
                                                  ),
                                                ),
                                                
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
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
                                            children: <Widget>[
                                              SizedBox(
                                              
                                                height: 60,
                                                child: Container(
                                                  // tag: '$i',
                                                  child: const Image(
                                                    // fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/document.png'),
                                                    // placeholder: (context, url) =>
                                                    //     Center(
                                                    //         child:
                                                    //             CircularProgressIndicator()),
                                                    // errorWidget:
                                                    //     (context, url, error) =>
                                                    //         new Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              const ListTile(
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
                                    Container(
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
                                            children: <Widget>[
                                              SizedBox(
                                              
                                                height: 60,
                                                child: Container(
                                                  // tag: '$i',
                                                  child: const Image(
                                                    // fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/intermediary.png'),
                                                    // placeholder: (context, url) =>
                                                    //     Center(
                                                    //         child:
                                                    //             CircularProgressIndicator()),
                                                    // errorWidget:
                                                    //     (context, url, error) =>
                                                    //         new Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              const ListTile(
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
                                    Container(
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
                                            children: <Widget>[
                                              SizedBox(
                                              
                                                height: 60,
                                                child: Container(
                                                  // tag: '$i',
                                                  child: const Image(
                                                    // fit: BoxFit.cover,
                                                    image: AssetImage('assets/images/agreement.png'),
                                                    // placeholder: (context, url) =>
                                                    //     Center(
                                                    //         child:
                                                    //             CircularProgressIndicator()),
                                                    // errorWidget:
                                                    //     (context, url, error) =>
                                                    //         new Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              const ListTile(
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
                                    )
                              ]
                            ),
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
                                padding: const EdgeInsets.only(
                                    right: 8.0, top: 8.0, left: 8.0),
                                child: Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(255, 35, 20, 1),
                                      ),
                                      child: const Text('View Appoinments',
                                          style: TextStyle(color: Colors.white, fontSize: 18)),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/categorise');
                                      }),
                                ),
                              )
                        ],
                      ),
          ),
          ]
        )
                
      ),
    );
  }
}
