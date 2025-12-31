import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/details/widget/sura_content1.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/utils/App_Colors.dart';
import 'package:islami_app/utils/App_styles.dart';
import 'package:islami_app/utils/app_assets.dart';

class SuraDetailsScreen1 extends StatefulWidget {
  const SuraDetailsScreen1({super.key});

  @override
  State<SuraDetailsScreen1> createState() => _SuraDetailsScreen1State();
}

class _SuraDetailsScreen1State extends State<SuraDetailsScreen1> {
  List<String> verses = [];
  String suraContent = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int index = ModalRoute.of(context)?.settings.arguments as int;
    if (suraContent.isEmpty) {
      loadSuraFile(index);
    }
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          QuranResources.QuranEnglishList[index],
          style: AppStyles.bold20primary,
        ),
      ),
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Image.asset(
            AppAssets.suraDetailsBg,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Column(
              spacing: height * 0.04,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppAssets.leftImage),
                    Text(
                      QuranResources.QuranArabicList[index],
                      style: AppStyles.bold24primary,
                    ),
                    Image.asset(AppAssets.rightImage),
                    Text(
                      QuranResources.QuranEnglishList[index],
                      style: AppStyles.bold24primary,
                    ),
                  ],
                ),
                Expanded(
                  child: suraContent.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : SingleChildScrollView(
                          child: SuraContent1(content: suraContent),
                        ),
                ),
                SizedBox(height: height * 0.08),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void loadSuraFile(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/quran/${index + 1}.text',
    );
    List<String> lines = fileContent.split('\n');
    verses = lines;
    for (int i = 0; i < lines.length; i++) {
      lines[i] += '[${i + 1}]';
    }
    suraContent = lines.join();

    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
}
