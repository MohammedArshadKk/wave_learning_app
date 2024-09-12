import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CustomText(
            text: text,
            color: AppColors.secondaryColor,
            fontSize: 20,
            fontFamily: Fonts.primaryText,
            fontWeight: FontWeight.w600),
    );
  }
}