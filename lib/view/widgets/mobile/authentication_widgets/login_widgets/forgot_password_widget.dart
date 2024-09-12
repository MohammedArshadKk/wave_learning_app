import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/forgot_password.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Padding(
      padding:
          EdgeInsets.only(right: screenWidth * 0.05, top: screenHeight * 0.014),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>  ForgotPasswordScreen()));
            },
            child: CustomText(
                text: 'forgot password?',
                color: AppColors.primaryColor,
                fontSize: 14,
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
