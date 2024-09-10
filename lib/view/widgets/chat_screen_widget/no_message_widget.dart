import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class NoMessageWidget extends StatelessWidget {
  const NoMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
          text: 'No messages yet', 
          color: AppColors.secondaryColor,
          fontSize: 20,
          fontFamily: Fonts.primaryText,
          fontWeight: FontWeight.w600),
    );
  }
}
