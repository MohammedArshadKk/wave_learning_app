import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class MenuIconWidget extends StatelessWidget {
  const MenuIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PopupMenuButton(
        color: AppColors.primaryColor,
        onSelected: (value) {
          if (value == 'Remove') {
          } else if (value == 'Share') {}
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'Remove',
            child: CustomText(
              text: 'Remove',
              color: AppColors.backgroundColor,
              fontSize: 16,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.w500,
            ),
          ),
          PopupMenuItem(
            value: 'Share',
            child: CustomText(
              text: 'Share',
              color: AppColors.backgroundColor,
              fontSize: 16,
              fontFamily: Fonts.labelText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        icon: const Icon(Icons.more_vert),
      ),
    );
  }
}
