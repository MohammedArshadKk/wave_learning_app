import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_login_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
            text: 'have an account?',
            color: AppColors.primaryColor,
            fontSize: 16,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.normal),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const MobileLoginScreen()));
          },
          child: CustomText(
              text: 'Sign in',
              color: AppColors.primaryColor,
              fontSize: 16,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
