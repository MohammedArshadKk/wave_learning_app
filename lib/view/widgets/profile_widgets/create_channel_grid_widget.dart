import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/create_channel_screen.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/profile_widgets/profile_grid_view_item.dart';

class CreateChannelGridWidget extends StatelessWidget {
  const CreateChannelGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.createText,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => const CreateChannelScreen(
                    text: 'create',
                  )));
        },
        icon: AppIcons.createChannelIcon);
  }
}
