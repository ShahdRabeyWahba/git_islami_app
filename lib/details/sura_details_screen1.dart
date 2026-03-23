import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/details/widget/sura_content.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class SuraDetailsScreen1 extends StatefulWidget {
  const SuraDetailsScreen1({super.key});

  @override
  State<SuraDetailsScreen1> createState() => _SuraDetailsScreen1State();
}

class _SuraDetailsScreen1State extends State<SuraDetailsScreen1> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int index = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      backgroundColor: const Color(0xFF202020), // Matching Hadeth Details
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          QuranResources.QuranEnglishList[index],
          style: AppStyles.bold20primary,
        ),
      ),
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(AppAssets.leftImage),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(AppAssets.rightImage),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.mosqueImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                Text(
                  QuranResources.QuranArabicList[index],
                  style: AppStyles.bold24primary,
                ),
                SizedBox(height: height * 0.04), // Increased distance
                Expanded(
                  child: FutureBuilder<List<String>>(
                    future: loadSuraFile(index),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error loading Sura',
                            style: AppStyles.bold20primary,
                          ),
                        );
                      }
                      return RawScrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        thickness: 6,
                        radius: const Radius.circular(20),
                        thumbColor: AppColors.blackColor,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: (snapshot.data ?? [])
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              String verse = entry.value;
                              return SuraContent(
                                content: verse,
                                index: index,
                                verseIndex: index + 1,
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<String>> loadSuraFile(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/quran/${index + 1}.text',
    );

    // First try splitting by newlines
    List<String> lines = fileContent.split('\n');
    List<String> verses = lines
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    // If only 1 line was found, the whole sura is in one line
    // Split by verse number pattern like (1), (2), ... (286)
    if (verses.length <= 1 && verses.isNotEmpty) {
      String singleLine = verses[0];
      // Split using regex: keep the trailing verse number with the verse text
      final RegExp versePattern = RegExp(r'(?=\(\d+\)\s*)');
      List<String> parts = singleLine.split(versePattern);
      verses = parts
          .map((p) => p.trim())
          .where((p) => p.isNotEmpty)
          .toList();
    }

    await Future.delayed(const Duration(seconds: 1));
    return verses;
  }
}
