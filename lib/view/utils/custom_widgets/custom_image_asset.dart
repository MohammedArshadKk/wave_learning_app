import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';

class CustomImageAsset extends StatelessWidget {
  const CustomImageAsset(
      {super.key,
      required this.image,
      this.height = 0,
      this.width = 0,
      this.padding = 0,
      this.text = ''});
  final dynamic image;
  final double height;
  final double width;
  final double padding;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Image.asset(image),
              CustomText( 
                  text: text,
                  color: AppColors.primaryColor,
                  fontSize: 30,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.w900)
            ],
          )),
    );
  }
}
