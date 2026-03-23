import 'package:flutter/material.dart';
import 'package:islami_app/tabes/hadeth/hadeth_tab.dart';
import 'package:islami_app/tabes/quran/quran_tab.dart';
import 'package:islami_app/tabes/radio/radio_tab.dart';
import 'package:islami_app/tabes/sebha/sebha_tab.dart';
import 'package:islami_app/tabes/time/time_tab.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  late PageController _pageController;

  final List<String> backgroundImages = [
    AppAssets.quranBg,
    AppAssets.hadethBg,
    AppAssets.sebhaBg,
    AppAssets.radioBg,
    AppAssets.timeBg,
  ];

  final List<Widget> tabsList = [
    const QuranTab(),
    const HadethTab(),
    const SebhaTab(),
    const RadioTab(),
    const TimeTab(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // Responsive Background Image
        Image.asset(
          backgroundImages[selectedIndex],
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.whiteColor,
            selectedLabelStyle: AppStyles.bold14White,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primaryColor,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            items: [
              buildBottomNavigationBarItem(
                  0, AppAssets.iconQuran, AppAssets.iconQuranSelected, 'Quran'),
              buildBottomNavigationBarItem(
                  1, AppAssets.iconHadeth, AppAssets.iconHadethSelected,
                  'Hadeth'),
              buildBottomNavigationBarItem(
                  2, AppAssets.iconSebha, AppAssets.iconSebhaSelected, 'Sebha'),
              buildBottomNavigationBarItem(
                  3, AppAssets.iconRadio, AppAssets.iconRadioSelected, 'Radio'),
              buildBottomNavigationBarItem(
                  4, AppAssets.iconTime, AppAssets.iconTimeSelected, 'Time'),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Image.asset(AppAssets.logo, height: height * 0.18),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (selectedIndex != index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    }
                  },
                  children: tabsList,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(int index, String icon,
      String activeIcon, String label) {
    bool isSelected = selectedIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 30,
        // Shorter Box as requested
        width: 65,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF202020).withOpacity(0.5) : Colors
              .transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          icon,
          height: 33, // Slightly smaller icon (from 40 to 33)
          fit: BoxFit.contain,
          color: AppColors.blackColor,
        ),
      ),
      label: label,
    );
  }
}
