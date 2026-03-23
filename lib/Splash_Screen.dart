import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  static const String routName = AppRoutes.splashRoute;

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashState = 0; // 0 for Phase 1, 1 for Phase 2

  @override
  void initState() {
    super.initState();
    _startSplashFlow();
  }

  void _startSplashFlow() async {
    // Show first splash for 5 seconds
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      setState(() {
        splashState = 1;
      });
    }
    // Show second splash for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.introRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        child: splashState == 0 ? _buildPhase1() : _buildPhase2(),
      ),
    );
  }

  Widget _buildPhase1() {
    return Container(
      key: const ValueKey('phase1'),
      width: double.infinity,
      height: double.infinity,
      child: Image.asset('assets/images/Splash Screen.png', fit: BoxFit.cover),
    );
  }

  Widget _buildPhase2() {
    return Stack(
      key: const ValueKey('phase2'),
      children: [
        Center(
          child: Image.asset(
            AppAssets.splashLogo,
            width: 240,
          ).animate().scale(duration: 600.ms, begin: const Offset(1.1, 1.1)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Image.asset(AppAssets.logoImage, width: 240),
          ),
        ).animate().fadeIn(),
      ],
    );
  }
}
