import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/utils/App_styles.dart';
import 'package:islami_app/utils/app_assets.dart';

class SuraItemWidget extends StatelessWidget {
  final int index;

  const SuraItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      spacing: width * 0.06,
      children: [
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Image.asset(AppAssets.vectorImage),
            Text('${index + 1}', style: AppStyles.bold20White),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                QuranResources.QuranEnglishList[index],
                style: AppStyles.bold20White,
              ),
              Text(
                '${QuranResources.versesNumberList[index]}verses',
                style: AppStyles.bold14White,
              ),
              Text(
                QuranResources.QuranArabicList[index],
                style: AppStyles.bold20White,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
