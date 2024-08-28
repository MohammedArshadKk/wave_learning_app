import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wave_learning_app/view/utils/colors.dart';

void customLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
            child: LoadingAnimationWidget.inkDrop(
                color: AppColors.backgroundColor, size: 40),
          ));
}
