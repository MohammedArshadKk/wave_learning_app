import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_signup_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class DontHaveAnAccountTextWidget extends StatelessWidget {
  const DontHaveAnAccountTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
            text: 'Don’t have an account?',
            color: AppColors.primaryColor,
            fontSize: 16,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.normal),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const MobileSignUpScreen()));
          },
          child: CustomText(
              text: 'Sign up',
              color: AppColors.primaryColor,
              fontSize: 16,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
