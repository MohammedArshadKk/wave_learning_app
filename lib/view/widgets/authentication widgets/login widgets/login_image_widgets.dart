import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_image_asset.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class LoginImageWidgets extends StatelessWidget {
  const LoginImageWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return CustomImageAsset(
      image: AppImages.signInImage,
      height: screenHeight * 0.38,
      width: double.infinity,
      padding: 25,
      text: 'Sign in',
    );
  }
}
