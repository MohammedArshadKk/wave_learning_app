import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class NameAndMembers extends StatelessWidget {
  const NameAndMembers({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
            text: name,
            color: AppColors.secondaryColor,
            fontSize: 30,
            fontFamily: Fonts.primaryText,
            fontWeight: FontWeight.bold),
        CustomText(
            text: '10 members',
            color: AppColors.lightTextColor,
            fontSize: 16,
            fontFamily: Fonts.primaryText,
            fontWeight: FontWeight.normal),
      ],
    );
  }
}
