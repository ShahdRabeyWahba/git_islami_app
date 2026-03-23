import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/tabes/quran/shared_prefs.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:islami_app/utils/app_styles.dart';

import 'widget/most_recently.dart';
import 'widget/sura_item_widget.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<int> list = List.generate(114, (index) => index,);
  List<int> mostRecentList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadMostRecentList();
  }

  void loadMostRecentList() async {
    mostRecentList = await getLastSuraIndex();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.02),
          TextField(
            cursorColor: AppColors.primaryColor,
            style: AppStyles.bold16White,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppAssets.quranSearch, height: 20),
              ),
              hintText: 'Sura Name (English / عربي)',
              hintStyle: AppStyles.bold16White.copyWith(
                  color: AppColors.whiteColor.withOpacity(0.6)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
            ),
            onChanged: (newText) {
              searchByNewsText(newText);
            },
          ),
          SizedBox(height: height * 0.02),
          MostRecently(mostRecentList: mostRecentList,),
          Expanded(
            child: RawScrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thumbColor: AppColors.darkColor,
              radius: const Radius.circular(20),
              thickness: 4,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    Text('Sura List', style: AppStyles.bold16White),
                    SizedBox(height: height * 0.01),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            saveLastSuraIndex(list[index]);
                            await Navigator.of(context).pushNamed(
                              AppRoutes.suraDetailsScreen1Route,
                              arguments: list[index],
                            );
                            loadMostRecentList();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            // Reduced vertical padding
                            child: SuraItemWidget(index: list[index]),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: AppColors.whiteColor,
                          thickness: 1, // Thinner divider
                          indent: width * 0.06,
                          endIndent: width * 0.06,
                        );
                      },
                      itemCount: list.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchByNewsText(String newText) {
    String query = newText.toLowerCase().trim();

    if (query.isEmpty) {
      list = List.generate(114, (index) => index);
      setState(() {});
      return;
    }

    // Simple normalization for Arabic search (e.g. Treat أ, إ, آ as ا)
    String normalizeArabic(String text) {
      // Remove tashkeel/diacritics and normalize letters
      text = text.replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '');
      return text
          .replaceAll('أ', 'ا')
          .replaceAll('إ', 'ا')
          .replaceAll('آ', 'ا')
          .replaceAll('ة', 'ه');
    }

    String normalizedQuery = normalizeArabic(query);
    // Remove "سوره" or "سورة" from the start of the query to allow matching the actual sura name
    normalizedQuery =
        normalizedQuery.replaceAll('سوره ', '').replaceAll('سوره', '');

    List<int> listSearch = [];

    for (int i = 0; i < 114; i++) {
      String engSura = QuranResources.QuranEnglishList[i].toLowerCase();
      String arbSura = normalizeArabic(QuranResources.QuranArabicList[i]);

      if (engSura.contains(query) || arbSura.contains(normalizedQuery)) {
        listSearch.add(i);
      }
    }
    list = listSearch;
    setState(() {});
  }
}
