import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class SignImageWidget extends StatelessWidget {
  const SignImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // var screenWidth = screenSize.width;
    // var screenHeight = screenSize.height;

     return Column(
      children: [
        Image.asset(AppImages.signUpImage),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
              text: "Sgin in",
              color: AppColors.primaryColor,
              fontSize: 30,
              fontFamily: Fonts.primaryText,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
