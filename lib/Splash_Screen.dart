import 'package:flutter/material.dart';
import 'package:islami_app/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routName = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, IntroScreen.routName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/images/splash.png', width: 200, height: 200),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 80,
        child: Center(
          child: Image.asset(
            'assets/images/logo_image.png',
            width: 60,
            height: 60,
          ),
        ),
      ),
    );
  }
}
