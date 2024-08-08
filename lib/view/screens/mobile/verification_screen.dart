import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view%20model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_image_asset.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageAsset(
                image: AppImages.verifyImage,
                height: 450,
                width: double.infinity,
              ),
            ),
            CustomText(
                text: 'Email verification',
                color: AppColors.secondaryColor,
                fontSize: 30,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.bold),
            CustomText(
                text: 'We sent a verification link to',
                color: AppColors.secondaryColor,
                fontSize: 20,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal),
            CustomText(
                text: '${_auth.currentUser?.email}',
                color: AppColors.secondaryColor,
                fontSize: 20,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  context.read<AuthenticationBloc>().add(VerifyEmailEvent(context: context));
                },
                child: CustomContainer(
                  height: 55,
                  width: 300,
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
            ),
          ],
        ),
      ),
    );
  }
}
