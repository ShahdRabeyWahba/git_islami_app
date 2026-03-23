import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami_app/home/home_screen.dart';
import 'package:islami_app/utils/app_colors.dart';

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
        titleSpacing: 0,
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.25,
        title: null,
        flexibleSpace: SafeArea(
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
          ),
        ),
      ),
      body: IntroductionScreen(
        globalBackgroundColor: AppColors.darkColor,
        showNextButton: true,
        showBackButton: true,
        showDoneButton: true,
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppColors.primaryColor,
          color: Colors.grey,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)),
        ),
        next: Text(
          "Next",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        back: Text(
          "Back",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        done: Text(
          "Finish",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onDone: () {
          _onIntroEnd(context);
        },
        pages: [
          _buildPage(
            title: "Welcome To Islami App",
            body: "We Are Very Excited To Have You In Our Community",
            image: 'assets/images/Frame1.png',
            context: context,
          ),
          _buildPage(
            title: "Reading the Quran",
            body: "Read, and your Lord is the Most Generous",
            image: 'assets/images/Frame2.png',
            context: context,
          ),
          _buildPage(
            title: "Bearish",
            body: "Praise the name of your Lord, the Most High",
            image: 'assets/images/Frame4.png',
            context: context,
          ),
          _buildPage(
            title: "Holy Quran Radio",
            body: "You can listen to the Holy Quran Radio through the application for free and easily",
            image: 'assets/images/Frame5.png',
            context: context,
          ),
        ],
      ),
    );
  }

  static PageViewModel _buildPage({
    required String title,
    required String body,
    required String image,
    required BuildContext context,
  }) {
    return PageViewModel(
      title: "",
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImage(image, context),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 20),
        ],
      ),
      decoration: pageDecoration,
    );
  }

  static Widget _buildImage(String assetName, BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Image.asset(assetName,
        width: size.width, height: size.height * 0.30, fit: BoxFit.contain);
  }

  static const PageDecoration pageDecoration = PageDecoration(
    bodyAlignment: Alignment.center,
    imagePadding: EdgeInsets.all(16),
  );

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
  }
}
