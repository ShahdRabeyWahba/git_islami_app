import 'package:flutter/material.dart';

import 'home_screen.dart';

class IntroductionScreen extends StatefulWidget {
  static const String routeName = "Introduction_Screen";

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> images = [
    "assets/images/Splash_Screen2.png",
    "assets/images/Intro Screen(1).png",
    "assets/images/Intro Screen (2).png",
    "assets/images/Intro Screen (3).png",
    "assets/images/Intro Screen(4).png",
    "assets/images/Intro Screen (5).png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: images.length,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Page ${index + 1}", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Image.asset(images[index], width: 300, height: 300),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routName);
              },
              child: Text("Skip"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_currentPage == images.length - 1) {
                  Navigator.pushReplacementNamed(context, HomeScreen.routName);
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text(_currentPage == images.length - 1 ? "Done" : "Next"),
            ),
          ],
        ),
      ),
    );
  }
}
