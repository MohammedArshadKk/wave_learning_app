import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class WebAuthText extends StatelessWidget {
  const WebAuthText({super.key, required this.text, required this.fontSize});
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
 

    return CustomText(
      text: text,
      color: AppColors.primaryColor,
      fontSize: fontSize,
      fontFamily: Fonts.primaryText,
      fontWeight: FontWeight.w900,
    );
  }
}
