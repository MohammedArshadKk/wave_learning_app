import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widgets/custom_text.dart';

class SettingsItomsWidgets extends StatelessWidget {
  const SettingsItomsWidgets(
      {super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CustomContainer(
        height: 60,
        width: double.infinity,
        color: AppColors.settingsColor,
        borderRadius: BorderRadius.circular(10),
        borderColor: Border.all(),
        child: Center(
          child: ListTile(
            leading: Icon(icon),
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: CustomText(
                  text: text,
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
