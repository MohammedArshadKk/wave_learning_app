import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_history_wedget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_like_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_settings_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_user_videos_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_watch_later_widget.dart';

class WebProfileScreen extends StatelessWidget {
  const WebProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
          children: const [
            GridHistoryWedget(),
            GridLikeWidget(),
            GridWatchLaterWidget(),
            GridUserVideosWidget(),
            GridSettingsWidget(),
          ],
        ),
      ),
    );
  }
}
