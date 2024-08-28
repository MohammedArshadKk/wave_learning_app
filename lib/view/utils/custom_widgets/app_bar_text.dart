import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Center(
        child: CustomText(
            text: text,
            color: AppColors.backgroundColor,
            fontSize: 25,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
