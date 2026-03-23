import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_styles.dart';

class HadethContent extends StatelessWidget {
  const HadethContent({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: AppStyles.bold20primary.copyWith(
          fontSize: 20,
          height: 2.0,
        ),
      ),
    );
  }
}
