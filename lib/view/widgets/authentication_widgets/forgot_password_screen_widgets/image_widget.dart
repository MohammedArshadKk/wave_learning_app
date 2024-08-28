import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_image_asset.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ForgotPasswordImageWidget extends StatelessWidget {
  const ForgotPasswordImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomImageAsset(
        image: AppImages.forgotPasswordImage,
        height: 300,
        width: double.infinity,
      ),
    );
  }
}
