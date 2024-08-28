import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class AfterLinkSendWidget extends StatelessWidget {
  const AfterLinkSendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CustomText(
              text: 'We sent a reset password link to',
              color: AppColors.secondaryColor,
              fontSize: 20,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.normal),
          CustomText(
              text: 'email',
              color: AppColors.secondaryColor,
              fontSize: 20,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}
