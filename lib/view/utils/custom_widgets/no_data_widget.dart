import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key,  this.text='No Data'}); 
 final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Image.asset(AppImages.noDataImage),
          CustomText(
              text: text,
              color: AppColors.secondaryColor,
              fontSize: 20,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.w600)
        ],
      ),
    );
  }
}
