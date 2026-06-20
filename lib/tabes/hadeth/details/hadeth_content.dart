import 'package:flutter/material.dart';
import 'package:islami_app/utils/App_styles.dart';

class HadethContent extends StatelessWidget {
  const HadethContent({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: AppStyles.bold20primary,
    );
  }
}
