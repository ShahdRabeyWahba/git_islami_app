import 'package:flutter/material.dart';
import 'package:islami_app/details/sura_details_screen.dart';
import 'package:islami_app/details/sura_details_screen1.dart';
import 'package:islami_app/home/home_screen.dart';
import 'package:islami_app/intro_screen.dart';
import 'package:islami_app/splash_screen.dart';
import 'package:islami_app/tabes/hadeth/details/hadeth_details_screen1.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:islami_app/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      routes: {
        AppRoutes.homescreenRoute: (context) => const HomeScreen(),
        AppRoutes.introRoute: (context) => const IntroScreen(),
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
