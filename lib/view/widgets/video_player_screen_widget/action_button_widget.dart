import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 40,
      width: 80,
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Center(
        child: Icon(
          icon,
          color: AppColors.backgroundColor,
          size: 20,
        ),
      ),
    );
  }
}
