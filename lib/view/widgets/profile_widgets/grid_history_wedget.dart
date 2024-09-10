import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/history_screen.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/profile_widgets/profile_grid_view_item.dart';

class GridHistoryWedget extends StatelessWidget {
  const GridHistoryWedget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.historyText,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const HistoryScreen()));
        },
        icon: AppIcons.historyIcon);
  }
}
