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
      if (mounted) {
        Navigator.pushReplacementNamed(context, IntroScreen.routName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/splash.png',
              width: size.width * 0.8,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo_image.png',
                width: size.width * 0.25,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
