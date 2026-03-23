import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),
  );
}
