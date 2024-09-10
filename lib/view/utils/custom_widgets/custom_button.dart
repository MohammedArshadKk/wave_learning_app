import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: CustomContainer(
        height: screenHeight * 0.06,
        width: screenWidth,
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: CustomText(
              text: text,
              color: AppColors.backgroundColor,
              fontSize: 20,
              fontFamily: Fonts.primaryText,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
