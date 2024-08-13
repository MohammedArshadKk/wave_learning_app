import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Center(
        child: CustomText(
            text: 'Settings',
            color: AppColors.backgroundColor,
            fontSize: 25,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
