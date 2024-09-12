import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      child: GestureDetector(
        onTap: () {
          context.read<AuthenticationBloc>().add(SignInWithGoogleEvent());
        },
        child: CustomContainer(
          height: screenHeight * 0.08,
          width: screenWidth * 0.26,
          borderColor: Border.all(color: AppColors.lightTextColor),
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.googleIcon,
                  height: screenHeight * 0.04,
                  width: screenHeight * 0.04,
                ),
                SizedBox(width: screenWidth * 0.01),
                CustomText(
                  text: text, 
                  color: AppColors.secondaryColor,
                  fontSize: screenHeight * 0.02,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
