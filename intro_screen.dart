import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/home/home_screen.dart';
import 'package:islami_app/utils/App_Colors.dart';

class IntroScreen extends StatelessWidget {
  static const String routName = 'intro_screen';

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          height: 100,
          width: 100,
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      ),
      body: IntroductionScreen(
        globalBackgroundColor: AppColors.darkColor,
        showNextButton: true,
        showBackButton: true,
        showDoneButton: true,

        next: Text(
          "Next",
          style: TextStyle(
            color: AppColors.goldColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        back: Text(
          "Back",
          style: TextStyle(
            color: AppColors.goldColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        done: Text(
          "Finish",
          style: TextStyle(
            color: AppColors.goldColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        onDone: () {
          _onIntroEnd(context);
        },

        pages: [
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage('assets/images/Frame1.png'),
                const SizedBox(height: 20),
                const Text(
                  "Welcome To Islami App",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "We Are Very Excited To Have You In Our Community",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
                ),
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage('assets/images/Frame2.png'),
                const SizedBox(height: 20),
                const Text(
                  "Reading the Quran",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Read, and your Lord is the Most Generous",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
                ),
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage('assets/images/Frame3.png'),
                const SizedBox(height: 20),
                const Text(
                  "Bearish",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Praise the name of your Lord, the Most High",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
                ),
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage('assets/images/Frame4.png'),
                const SizedBox(height: 20),
                const Text(
                  "Bearish",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Praise the name of your Lord, the Most High",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
                ),
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage('assets/images/Frame5.png'),
                const SizedBox(height: 20),
                const Text(
                  "Holy Quran Radio",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You can listen to the Holy Quran Radio through the application for free and easily",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
                ),
              ],
            ),
            decoration: pageDecoration,
          ),
        ],
      ),
    );
  }

  static Widget _buildImage(String assetName, [double width = 200]) {
    return Image.asset(assetName, width: width);
  }

  static const PageDecoration pageDecoration = PageDecoration(
    bodyAlignment: Alignment.center,
    imagePadding: EdgeInsets.all(16),
  );

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
  }
}
