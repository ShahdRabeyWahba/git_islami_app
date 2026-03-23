import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_styles.dart';

class SuraItemWidget extends StatelessWidget {
  final int index;

  const SuraItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      spacing: width * 0.03, // Tighter spacing
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 45, // Smaller vector icon
              child: Image.asset(AppAssets.vectorImage, fit: BoxFit.contain),
            ),
            Text('${index + 1}', style: AppStyles.bold16White),
            // Smaller index font
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                QuranResources.QuranEnglishList[index],
                style: AppStyles.bold16White, // Smaller title font
              ),
              Text(
                '${QuranResources.versesNumberList[index]} Verses',
                style: AppStyles.bold14White.copyWith(
                    fontSize: 12), // Smaller verse count
              ),
            ],
          ),
        ),
        Text(
          QuranResources.QuranArabicList[index],
          style: AppStyles.bold16White, // Smaller Arabic title font
        ),
      ],
    );
  }
}
