import 'package:flutter/material.dart';
import 'package:islami_app/model/hadeth_details_args.dart';
import 'package:islami_app/tabes/hadeth/hadeth.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:islami_app/utils/app_styles.dart';

class HadethItem extends StatelessWidget {
  final Hadeth hadeth;
  final int index;

  const HadethItem({super.key, required this.hadeth, required this.index});

  String _getArabicOrder(int index) {
    const arabicOrders = [
      'الأول',
      'الثاني',
      'الثالث',
      'الرابع',
      'الخامس',
      'السادس',
      'السابع',
      'الثامن',
      'التاسع',
      'العاشر',
      'الحادي عشر',
      'الثاني عشر',
      'الثالث عشر',
      'الرابع عشر',
      'الخامس عشر',
      'السادس عشر',
      'السابع عشر',
      'الثامن عشر',
      'التاسع عشر',
      'العشرون',
      'الحادي والعشرون',
      'الثاني والعشرون',
      'الثالث والعشرون',
      'الرابع والعشرون',
      'الخامس والعشرون',
      'السادس والعشرون',
      'السابع والعشرون',
      'الثامن والعشرون',
      'التاسع والعشرون',
      'الثلاثون',
      'الحادي والثلاثون',
      'الثاني والثلاثون',
      'الثالث والثلاثون',
      'الرابع والثلاثون',
      'الخامس والثلاثون',
      'السادس والثلاثون',
      'السابع والثلاثون',
      'الثامن والثلاثون',
      'التاسع والثلاثون',
      'الأربعون',
      'الحادي والأربعون',
      'الثاني والأربعون',
      'الثالث والأربعون',
      'الرابع والأربعون',
      'الخامس والأربعون',
      'السادس والأربعون',
      'السابع والأربعون',
      'الثامن والأربعون',
      'التاسع والأربعون',
      'الخمسون',
    ];
    return (index > 0 && index <= arabicOrders.length)
        ? arabicOrders[index - 1]
        : '$index';
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Center(
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.asset(
                        AppAssets.hadethBackGround,
                        width: width * 0.7,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      AppAssets.mosque2Bg,
                      width: double.infinity,
                      height: height * 0.10,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.04,
                          right: width * 0.04,
                          bottom: height * 0.08),
                      child: Column(
                        children: [
                          const SizedBox(height: 35),
                          Text(
                            'الحديث ${_getArabicOrder(index + 1)}',
                            style: AppStyles.bold24Dark.copyWith(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04),
                            child: Text(
                              hadeth.title,
                              textAlign: TextAlign.center,
                              style: AppStyles.bold16dark.copyWith(
                                  color: AppColors.blackColor, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.hadethDetailsScreen1Route,
                                    arguments: HadethDetailsArgs(
                                      hadeth: hadeth,
                                      index: index + 1,
                                    ),
                                  );
                                },
                                child: Text(
                                  hadeth.content,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.bold16dark.copyWith(
                                      fontSize: 22,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Image.asset(
              AppAssets.leftImage,
              width: 75,
              color: AppColors.blackColor,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(
              AppAssets.rightImage,
              width: 75,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}