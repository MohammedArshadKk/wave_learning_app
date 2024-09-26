import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.text = 'No Data'});

  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 100 : 70,
        horizontal: 20,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              AppImages.noDataImage,
              height: isLargeScreen ? size.height * 0.3 : size.height * 0.2,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(top: isLargeScreen ? 0 : 20),
              child: CustomText(
                text: text,
                color: AppColors.secondaryColor,
                fontSize: isLargeScreen ? 24 : 20,
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
  