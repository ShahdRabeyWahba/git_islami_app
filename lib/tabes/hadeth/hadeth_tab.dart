import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/api/api_manager.dart';
import 'package:islami_app/model/hadeth_response.dart';
import 'package:islami_app/tabes/hadeth/hadeth.dart';
import 'package:islami_app/tabes/hadeth/widget/hadeth_item.dart';
import 'package:islami_app/utils/app_colors.dart';

class HadethTab extends StatelessWidget {
  const HadethTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder<HadethBookResponse>(
      future: ApiManager.getHadethBook(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}",
              style: const TextStyle(color: Colors.white)));
        } else {
          var apiHadiths = snapshot.data?.data?.hadiths ?? [];
          List<Hadeth> hadethList = apiHadiths.map((h) =>
              Hadeth(
                  title: "",
                  content: h.arab ?? ""
              )).toList();

          return Padding(
            padding: EdgeInsets.only(bottom: height * 0.01),
            child: CarouselSlider(
              options: CarouselOptions(
                height: height * 0.68,
                viewportFraction: 0.85,
                aspectRatio: 1 / 1.5,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                enableInfiniteScroll: false,
              ),
              items: hadethList
                  .asMap()
                  .entries
                  .map((entry) {
                int index = entry.key;
                Hadeth hadeth = entry.value;
                return HadethItem(
                  hadeth: hadeth,
                  index: index,
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

