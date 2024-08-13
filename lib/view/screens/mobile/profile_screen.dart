import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/check%20channel%20created%20or%20not/channel_created_or_not_bloc.dart';
import 'package:wave_learning_app/view_model/functions/init_functions.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/about_channel_widget.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/create_channel_grid_widget.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/grid_history_wedget.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/grid_like_widget.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/grid_settings_widget.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/grid_user_videos_widget.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/grid_watch_later_widget.dart';
import 'package:wave_learning_app/view/widgets/profile%20widgets/profile_user_details.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  initState() {
    profileInit(context, _auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            ProfileUserDetails(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                children: [
                  BlocBuilder<ChannelCreatedOrNotBloc,
                      ChannelCreatedOrNotState>(
                    builder: (context, state) {
                      if (state is ChannelCreatedState) {
                        return const AboutChannelWidget();
                      } else {
                        return const CreateChannelGridWidget();
                      }
                    },
                  ),
                  const GridHistoryWedget(),
                  const GridLikeWidget(),
                  const GridWatchLaterWidget(),
                  const GridUserVideosWidget(),
                  const GridSettingsWidget(),
                ],
              ),
            )
          ],
        ));
  }
}
