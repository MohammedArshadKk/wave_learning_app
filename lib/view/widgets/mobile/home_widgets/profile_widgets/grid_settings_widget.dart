import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/settings_screen.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/profile_grid_view_item.dart';

class GridSettingsWidget extends StatelessWidget {
  const GridSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.settingsText,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SettingsScreen()));
        },
        icon: AppIcons.settingsIcon);
  }
}
