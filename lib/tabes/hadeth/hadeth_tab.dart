import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/tabes/hadeth/widget/hadeth_item.dart';

class HadethTab extends StatelessWidget {
  const HadethTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: CarouselSlider(
        options: CarouselOptions(
          height: height * 0.66,
          aspectRatio: 313 / 618,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
        ),
        items: List.generate(6, (index) => index + 1).map((index) {
          return HadethItem(index: index);
        }).toList(),
      ),
    );
  }
}
