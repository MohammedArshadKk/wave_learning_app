import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_history_wedget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_like_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_settings_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_user_videos_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/grid_watch_later_widget.dart';

class WebProfileScreen extends StatelessWidget {
  const WebProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200 ? 4 : (screenWidth > 800 ? 3 : 2);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    GridHistoryWedget(),
                    GridLikeWidget(),
                    GridWatchLaterWidget(),
                    GridUserVideosWidget(),
                    GridSettingsWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
