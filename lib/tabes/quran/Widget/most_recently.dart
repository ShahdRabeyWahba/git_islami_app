import 'package:flutter/material.dart';

import '../../../model/quran_resources.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class MostRecently extends StatefulWidget {
  final List<int> mostRecentList;

  const MostRecently({super.key, required this.mostRecentList});

  @override
  State<MostRecently> createState() => _MostRecentlyState();
}

class _MostRecentlyState extends State<MostRecently> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Visibility(
      visible: widget.mostRecentList.isNotEmpty,
      child: Column(
        spacing: height * 0.02,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Most Recently', style: AppStyles.bold16White),
          SizedBox(
            height: height * 0.18,
            child: RawScrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thumbColor: AppColors.darkColor,
              radius: const Radius.circular(20),
              thickness: 4,
              child: ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                QuranResources.QuranEnglishList[widget
                                    .mostRecentList[index]],
                                style: AppStyles.bold24Dark,
                              ),
                              Text(
                                QuranResources.QuranArabicList[widget
                                    .mostRecentList[index]],
                                style: AppStyles.bold24Dark,
                              ),
                              Text(
                                '${QuranResources.versesNumberList[widget.mostRecentList[index]]} Verses',
                                style: AppStyles.bold14Dark,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(AppAssets.mostRecentImage),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: width * 0.04);
                },
                itemCount: widget.mostRecentList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
