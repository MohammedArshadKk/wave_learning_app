import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ImageAuthWeb extends StatelessWidget {
  const ImageAuthWeb({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.1),
      child: CustomContainer(
        height: screenHeight * 0.9,
        width: screenWidth * 0.5,
        child: Image.asset(image),
      ),
    );
  }
}
