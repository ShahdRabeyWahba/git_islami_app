import 'package:flutter/material.dart';
import 'package:islami_app/model/hadeth_details_args.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class HadethDetailsScreen1 extends StatelessWidget {
  static const String routName = 'HadethDetailsScreen1';

  const HadethDetailsScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute
        .of(context)!
        .settings
        .arguments as HadethDetailsArgs;
    var hadeth = args.hadeth;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF202020), // Background from image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Hadith ${args.index}',
          style: AppStyles.bold20White.copyWith(color: AppColors.primaryColor),
        ),

      ),
      body: Stack(
        children: [
          // Corner Decorations
          Positioned(
            top: 15,
            left: 15,
            child: Image.asset(
              AppAssets.leftImage,
              width: 80,
              color: AppColors.primaryColor,
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Image.asset(
              AppAssets.rightImage,
              width: 80,
              color: AppColors.primaryColor,
            ),
          ),
          // Bottom mosque silhouette like image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.mosque2Bg,
              width: double.infinity,
              height: height * 0.20,
              fit: BoxFit.fill,
            ),
          ),
          // Content Scroll
          Column(
            children: [
              const SizedBox(height: 25),
              // Header Row with Title BETWEEN Gold Decorations (Forced Width)
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: Image.asset(
                          AppAssets.leftCorner, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'الحديث ${_getArabicOrder(args.index)}',
                      style: AppStyles.bold24Dark.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: Image.asset(
                          AppAssets.rightCorner, fit: BoxFit.contain),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 150),
                  child: Text(
                    hadeth.content,
                    textAlign: TextAlign.center,
                    style: AppStyles.bold16White.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getArabicOrder(int index) {
    List<String> arabicOrders = [
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
      'الخمسون'
    ];
    if (index >= 1 && index <= 50) {
      return arabicOrders[index - 1];
    }
    return index.toString();
  }
}
