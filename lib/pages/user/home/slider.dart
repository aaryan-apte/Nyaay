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
                autoPlay: true,
                height: 500,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1.0
              ),
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: i,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator()
                          ),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        )
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
