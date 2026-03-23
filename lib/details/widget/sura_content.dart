import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class SuraContent extends StatefulWidget {
  const SuraContent(
      {super.key, required this.content, required this.index, required this.verseIndex});

  final String content;
  final int index;
  final int verseIndex;

  @override
  State<SuraContent> createState() => _SuraContentState();
}

class _SuraContentState extends State<SuraContent> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: height * 0.005),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.primaryColor, width: 1.5),
        ),
        child: Text(
          "${widget.content} (${widget.verseIndex})",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: AppStyles.bold16White.copyWith(
            color: isSelected ? AppColors.blackColor : AppColors.primaryColor,
            fontSize: 24,
            height: 1.8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
