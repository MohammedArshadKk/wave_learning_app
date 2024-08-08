import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/profile_grid_view_item.dart';

class GridLikeWidget extends StatelessWidget {
  const GridLikeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.likedText, onTap: () {}, icon: AppIcons.likedIcon);
  }
}
