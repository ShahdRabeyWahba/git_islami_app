import 'package:flutter/material.dart';
import 'package:islami_app/Splash_Screen.dart';
import 'package:islami_app/details/sura_details_screen.dart';
import 'package:islami_app/details/sura_details_screen1.dart';
import 'package:islami_app/home/home_screen.dart';
import 'package:islami_app/intro_screen.dart';
import 'package:islami_app/tabes/hadeth/details/hadeth_details_screen1.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:islami_app/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      routes: {
        AppRoutes.homescreenRoute: (context) => HomeScreen(),
        AppRoutes.introRoute: (context) => IntroScreen(),
        AppRoutes.splashRoute: (context) => SplashScreen(),
        AppRoutes.suraDetailsScreenRoute: (context) => SuraDetailsScreen(),
        AppRoutes.suraDetailsScreen1Route: (context) => SuraDetailsScreen1(),
        AppRoutes.hadethDetailsScreen1Route: (context) =>
            HadethDetailsScreen1(),
      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}