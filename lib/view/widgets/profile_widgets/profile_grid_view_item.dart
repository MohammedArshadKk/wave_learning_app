import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ProfileGridViewItomWidget extends StatelessWidget {
  const ProfileGridViewItomWidget(
      {super.key, required this.text, required this.onTap, required this.icon});
  final String text;
  final Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        height: 150,
        width: 150,
        borderRadius: BorderRadius.circular(20),
        borderColor: Border.all(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            CustomText(
                text: text,
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal)
          ],
        ),
      ),
    );
  }
}
