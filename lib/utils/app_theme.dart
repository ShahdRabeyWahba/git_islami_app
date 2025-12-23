import 'package:flutter/material.dart';
import 'package:islami_app/utils/App_Colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.transparentColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: AppColors.whiteColor,
      ),
    ),
  );
}
