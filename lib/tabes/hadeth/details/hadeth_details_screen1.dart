import 'package:flutter/material.dart';
import 'package:islami_app/model/hadeth_details_args.dart';
import 'package:islami_app/tabes/hadeth/details/hadeth_content.dart';
import 'package:islami_app/utils/App_Colors.dart';
import 'package:islami_app/utils/App_styles.dart';
import 'package:islami_app/utils/app_assets.dart';

class HadethDetailsScreen1 extends StatelessWidget {
  const HadethDetailsScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    HadethDetailsArgs args =
        ModalRoute.of(context)?.settings.arguments as HadethDetailsArgs;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hadith${args.index}', style: AppStyles.bold20primary),
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
                    Text(args.hadeth.title, style: AppStyles.bold24primary),
                    Image.asset(AppAssets.rightImage),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: HadethContent(content: args.hadeth.content),
                  ),
                ),
                Image.asset(AppAssets.mosque2Bg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
