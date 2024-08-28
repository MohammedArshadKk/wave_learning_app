import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key,  this.description});
 final String? description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: CustomText(
              text: description ?? 'No Description ',
              color: AppColors.secondaryColor,
              fontSize: 18,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
