import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/web/forgot_password_screen_web.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ForgotPasswordWidgetWeb extends StatelessWidget {
  const ForgotPasswordWidgetWeb({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;

    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ForgotPasswordScreenWeb(),
              ));
            },
            child: CustomText(
              text: 'forgot password?',
              color: AppColors.primaryColor,
              fontSize: screenHeight * 0.016,
              fontFamily: Fonts.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
