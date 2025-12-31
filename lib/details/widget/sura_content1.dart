import 'package:flutter/material.dart';
import 'package:islami_app/utils/App_styles.dart';

class SuraContent1 extends StatelessWidget {
  const SuraContent1({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Text(
      content,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: AppStyles.bold20primary,
    );
  }
}
