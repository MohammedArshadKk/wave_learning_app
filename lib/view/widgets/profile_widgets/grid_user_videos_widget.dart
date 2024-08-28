import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/user_videos_screen.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/profile_widgets/profile_grid_view_item.dart';

class GridUserVideosWidget extends StatelessWidget {
  const GridUserVideosWidget({super.key});

  @override     
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.userVideoText,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) =>  const UserVideosScreen()));
        },
        icon: AppIcons.userVideoIcon);
  }
}
