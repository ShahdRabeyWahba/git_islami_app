import 'package:flutter/material.dart';
import 'package:islami_app/tabes/hadeth/hadeth_tab.dart';
import 'package:islami_app/tabes/quran/quran_tab.dart';
import 'package:islami_app/tabes/radio/radio_tab.dart';
import 'package:islami_app/tabes/sebha/sebha_tab.dart';
import 'package:islami_app/tabes/time/time_tab.dart';
import 'package:islami_app/utils/App_Colors.dart';
import 'package:islami_app/utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> backgroundImages = [
    AppAssets.QuranBg,
    AppAssets.HadethBg,
    AppAssets.SebhaBg,
    AppAssets.RadioBg,
    AppAssets.TimeBg,
  ];
  List<Widget> tabsList = [
    QuranTap(),
    HadethTab(),
    RadioTab(),
    SebhaTab(),
    TimeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(
          backgroundImages[selectedIndex],
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            selectedItemColor: AppColors.whiteColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primaryColor,
            items: [
              buildBottomNavigationBarItem(
                index: 0,
                iconName: AppAssets.iconQuran,
                iconSelectedName: AppAssets.iconQuranSelected,
                label: 'Quran',
              ),
              buildBottomNavigationBarItem(
                index: 1,
                iconName: AppAssets.iconHadeth,
                iconSelectedName: AppAssets.iconHadethSelected,
                label: 'Hadeth',
              ),
              buildBottomNavigationBarItem(
                index: 2,
                iconName: AppAssets.iconSebha,
                iconSelectedName: AppAssets.iconSebhaSelected,
                label: 'Sebha',
              ),
              buildBottomNavigationBarItem(
                index: 3,
                iconName: AppAssets.iconRadio,
                iconSelectedName: AppAssets.iconRadioSelected,
                label: 'Radio',
              ),
              buildBottomNavigationBarItem(
                index: 4,
                iconName: AppAssets.iconTime,
                iconSelectedName: AppAssets.iconTimeSelected,
                label: 'Time',
              ),
            ],
          ),
          body: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.logo, height: height * 0.16),
              Expanded(child: tabsList[selectedIndex]),
            ],
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String iconName,
    required String label,
    required String iconSelectedName,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(selectedIndex == index ? iconSelectedName : iconName),
      label: label,
    );
  }
}
