import 'package:flutter/material.dart';
import 'package:wave_learning_app/utils/colors.dart';
import 'package:wave_learning_app/utils/images_fonts.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_signup_screen.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_image_asset.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_text_form_field.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomImageAsset(
                  image: AppImages.signInImage,
                  height: screenHeight * 0.38,
                  width: double.infinity,
                  padding: 25, 
                  text: 'Sign in',   
                ),
                CustomTextFormField(
                  labelText: 'Email',
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.normal,
                  padding: 10,
                  fontSize: 18,
                  textColor: Colors.black,
                  paddingForm: 20,
                  borderRadius: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelText: 'Password',
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.normal,
                  padding: 10,
                  fontSize: 18,
                  textColor: Colors.black,
                  paddingForm: 20,
                  borderRadius: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.05, top: screenHeight * 0.014),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                          text: 'forgot password?',
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontFamily: Fonts.labelText,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomContainer(
                    height: 55,
                    width: 400,
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    child: Center(
                        child: CustomText(
                            text: 'Get Started',
                            color: AppColors.backgroundColor,
                            fontSize: 25,
                            fontFamily: Fonts.labelText,
                            fontWeight: FontWeight.normal)),
                  ),
                ),
                Row(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomContainer(
                    height: 60,
                    width: screenWidth * 1,
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    borderColor: Border.all(color: AppColors.lightTextColor),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            text: 'Sign in with google',
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontFamily: Fonts.labelText,
                            fontWeight: FontWeight.normal),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
