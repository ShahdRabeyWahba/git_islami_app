import 'package:flutter/material.dart';
import 'package:islami_app/utils/App_Colors.dart';
import 'package:islami_app/utils/App_styles.dart';
import 'package:islami_app/utils/app_assets.dart';

class QuranTap extends StatelessWidget {
  const QuranTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          cursorColor: AppColors.primaryColor,
          style: TextStyle(color: AppColors.whiteColor),
          decoration: InputDecoration(
            prefixIcon: Image.asset(AppAssets.quranSearch),
            hintText: 'Sura Name',
            hintStyle: AppStyles.bold16white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
