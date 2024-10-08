import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class TimeDiffAndViewsWidget extends StatelessWidget {
  const TimeDiffAndViewsWidget({super.key, required this.difference});
  final String difference;
  @override
  Widget build(BuildContext context) {
    return CustomText(
        text: difference,
        color: AppColors.secondaryColor,
        fontSize: 16,
        fontFamily: Fonts.primaryText,
        fontWeight: FontWeight.w500);
  }
}
