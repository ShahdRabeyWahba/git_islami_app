import 'package:flutter/material.dart';
import 'package:islami_app/Splash_Screen.dart';
import 'package:islami_app/home/home_screen.dart';
import 'package:islami_app/intro_screen.dart';
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
      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}