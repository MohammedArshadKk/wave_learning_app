import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class DontAndHaveAccountText extends StatelessWidget {
  const DontAndHaveAccountText({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.09),
      child: Row(
        children: [
          CustomText(
              text: text1,
              color: AppColors.primaryColor,
              fontSize: 16,
              fontFamily: Fonts.primaryText,
              fontWeight: FontWeight.normal),
          CustomText(
              text: text2,
              color: AppColors.primaryColor,
              fontSize: 18,
              fontFamily: Fonts.primaryText,
              fontWeight: FontWeight.w900),
        ],
      ),
    );
  }
}
