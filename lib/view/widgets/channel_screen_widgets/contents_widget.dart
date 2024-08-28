import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class AboutContentsWidget extends StatelessWidget {
  const AboutContentsWidget(
      {super.key, required this.width, required this.content});
  final double width;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: CustomText(
          text: content,
          color: AppColors.secondaryColor,
          fontSize: 16,
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.w500),
    );
  }
}
