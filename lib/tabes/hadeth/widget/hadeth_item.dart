import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/model/hadeth_details_args.dart';
import 'package:islami_app/tabes/hadeth/hadeth.dart';
import 'package:islami_app/utils/App_Colors.dart';
import 'package:islami_app/utils/App_styles.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_routes.dart';

class HadethItem extends StatefulWidget {
  final int index;

  HadethItem({super.key, required this.index});

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  Hadeth? hadeth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHadethFile(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(AppAssets.hadethBackGround)),
        color: AppColors.primaryColor,
      ),
      child: hadeth == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.blackColor,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Expanded(
                          child: Text(
                            hadeth?.title ?? '',
                            textAlign: TextAlign.center,
                            style: AppStyles.bold24Dark,
                          ),
                        ),
                      ),
                      Image.asset(AppAssets.leftCorner, width: width * 0.16),
                      Image.asset(AppAssets.rightCorner, width: width * 0.16),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: InkWell(
                        onTap: () {
                          //todo: navigate to hadeth details screen
                          Navigator.of(context).pushNamed(
                            AppRoutes.hadethDetailsScreen1Route,
                            arguments: HadethDetailsArgs(
                              hadeth: hadeth!,
                              index: widget.index,
                            ),
                          );
                        },
                        child: Text(
                          hadeth?.content ?? '',
                          textAlign: TextAlign.center,
                          style: AppStyles.bold16dark,
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  AppAssets.mosque2Bg,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
    );
  }

  void loadHadethFile(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/hadeth/h$index',
    );
    int fileContentIndex = fileContent.indexOf('\n');
    String title = fileContent.substring(0, fileContentIndex);
    String content = fileContent.substring(fileContentIndex + 1);
    hadeth = Hadeth(title: title, content: content);
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
}
