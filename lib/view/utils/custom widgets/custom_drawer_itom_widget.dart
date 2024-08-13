import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class CustomDrawerItomWidget extends StatelessWidget {
  const CustomDrawerItomWidget(
      {super.key, required this.text, required this.icon, this.onTap});
  final String text;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 29,
      ),
      title: CustomText(
          text: text,
          color: AppColors.secondaryColor,
          fontSize: 13,
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
