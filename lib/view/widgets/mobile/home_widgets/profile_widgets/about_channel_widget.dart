import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/about_channel_screen.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/profile_grid_view_item.dart';

class AboutChannelWidget extends StatelessWidget {
  const AboutChannelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: 'About channel',
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const AboutChannelScreen()));
        },
        icon: AppIcons.infoIcon);
  }
}
