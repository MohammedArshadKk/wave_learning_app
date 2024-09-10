import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class TabBarText extends StatelessWidget {
  const TabBarText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return CustomText(
        text: text,
        color: AppColors.backgroundColor,
        fontSize: 18,
        fontFamily: Fonts.primaryText,
        fontWeight: FontWeight.normal);
  }
}
