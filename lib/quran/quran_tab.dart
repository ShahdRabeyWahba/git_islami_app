import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/utils/App_Colors.dart';
import 'package:islami_app/utils/App_styles.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_routes.dart';

import 'Widget/Sura_item_widget.dart';

class QuranTap extends StatelessWidget {
  const QuranTap({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: height * 0.02,
      children: [
        TextField(
          cursorColor: AppColors.primaryColor,
          style: TextStyle(color: AppColors.whiteColor),
          decoration: InputDecoration(
            prefixIcon: Image.asset(AppAssets.quranSearch),
            hintText: 'Sura Name',
            hintStyle: AppStyles.bold16White,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
          ),
        ),
        Text('Most Recently', style: AppStyles.bold16White),
        SizedBox(
          height: height * 0.18,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primaryColor,
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Al-Anbiya', style: AppStyles.bold24Dark),
                        Text('الأنبياء', style: AppStyles.bold24Dark),
                        Text('112 Verses', style: AppStyles.bold14Dark),
                        Text('Sura List', style: AppStyles.bold16White),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //todo: navigate to sura details screen
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.suraDetailsScreenRoute,
                                    arguments: index,
                                  );
                                },
                                child: SuraItemWidget(index: index),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: AppColors.whiteColor,
                                thickness: 2,
                                indent: width * 0.06,
                                endIndent: width * 0.06,
                              );
                            },
                            itemCount: QuranResources.versesNumberList.length,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(AppAssets.mostRecentImage),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: width * 0.04);
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
