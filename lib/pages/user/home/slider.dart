import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

  final List<String> imgList = [
    'https://i.pinimg.com/564x/3e/e4/b0/3ee4b0cf4e46549e52194423136f35fb.jpg',
    'https://i.pinimg.com/564x/3e/e4/b0/3ee4b0cf4e46549e52194423136f35fb.jpg',
    'https://i.pinimg.com/564x/3e/e4/b0/3ee4b0cf4e46549e52194423136f35fb.jpg',
    'https://i.pinimg.com/564x/3e/e4/b0/3ee4b0cf4e46549e52194423136f35fb.jpg',
    'https://i.pinimg.com/564x/3e/e4/b0/3ee4b0cf4e46549e52194423136f35fb.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Center(
            child: CarouselSlider(
              options: CarouselOptions(
                // autoPlay: true,
                height: 500,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1.0
              ),
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                       children: <Widget>[
                       Container(
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: i,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator()
                            ),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                          )  
                      ),
                      Container(
                          decoration: BoxDecoration(
                        // color: Colors.white, // Background color
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
                        child: const Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children: <Widget>[
                            SizedBox(height: 230.0),
                            Text(
                                'NYAAY',
                                style: TextStyle(color: Colors.white, fontSize: 40.0),
                              ),
                              ]
                            ),
                          ),
                        ),
                      ),
                      ]
                    );
                  },
                );
              }).toList(),
      
            ),
          ),
        ],
      ),
    );
  }
}
