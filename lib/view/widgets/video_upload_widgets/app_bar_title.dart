import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 180,
        child: CustomText(
            text: "upload video",
            color: AppColors.secondaryColor,
            fontSize: 24,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
