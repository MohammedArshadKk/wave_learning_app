import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/profile_grid_view_item.dart';

class GridHistoryWedget extends StatelessWidget {
  const GridHistoryWedget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.historyText, onTap: () {}, icon: AppIcons.historyIcon);
  }
}
