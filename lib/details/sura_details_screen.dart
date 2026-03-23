import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/details/widget/sura_content.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    int index = ModalRoute.of(context)?.settings.arguments as int;
    if (verses.isEmpty) {
      loadSuraFile(index);
    }
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppAssets.suraDetailsBg,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            iconTheme: IconThemeData(
                color: AppColors.primaryColor
            ),
            title: Text(
              QuranResources.QuranEnglishList[index],
              style: AppStyles.bold20primary,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppAssets.leftImage),
                    Flexible(
                      child: Text(
                        QuranResources.QuranArabicList[index],
                        style: AppStyles.bold24primary,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image.asset(AppAssets.rightImage),
                  ],
                ),
                Expanded(
                    child: verses.isEmpty
                        ? Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor))
                        : RawScrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      thickness: 6,
                      radius: const Radius.circular(20),
                      thumbColor: AppColors.darkColor,
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.only(
                            top: height * 0.02, right: width * 0.02),
                        itemBuilder: (context, index) {
                          return SuraContent(
                            index: index,
                            content: verses[index],
                            verseIndex: index + 1,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: height * 0.02,
                          );
                        },
                        itemCount: verses.length,
                      ),
                    )),
                Image.asset(
                  AppAssets.mosqueImage,
                  height: height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void loadSuraFile(int index) async {
    String fileContent =
    await rootBundle.loadString('assets/files/quran/${index + 1}.text');
    List<String> lines = fileContent.split('\n');
    verses = lines;
    setState(() {});
  }
}