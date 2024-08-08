import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_image_asset.dart';

class WebLoginScreen extends StatelessWidget {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Scaffold( 
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomImageAsset( 
                image: AppImages.signInImage,
                height: screenHeight * 0.67,
                width: screenWidth*0.5,
                padding: screenWidth*0.04,
              )
            ],
          ),
        )); 
  }
}