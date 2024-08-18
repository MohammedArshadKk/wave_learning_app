import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/sam.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/profile_grid_view_item.dart';

class GridUserVideosWidget extends StatelessWidget {
  const GridUserVideosWidget({super.key});

  @override     
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.userVideoText,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) =>  UploadPage()));
        },
        icon: AppIcons.userVideoIcon);
  }
}
