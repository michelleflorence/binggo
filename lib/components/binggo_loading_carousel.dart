import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          height: MediaQuery.of(context).size.height / 4,
          aspectRatio: 16 / 9,
          enableInfiniteScroll: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 0.7),
      items: [1, 2, 3].map((e) {
        return Builder(builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[400],
            ),
          );
        });
      }).toList(),
    );
  }
}
