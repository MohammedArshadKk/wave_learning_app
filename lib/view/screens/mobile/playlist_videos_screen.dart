import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/playlist_model.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/screens/mobile/playlist_add_video_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/videos_widget.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_playlist_videos/fetch_playlist_videos_cubit.dart';

class PlaylistVideosScreen extends StatefulWidget {
  const PlaylistVideosScreen(
      {super.key,
      // required this.videos,
      required this.userVideo,
      required this.playlistModel});
  // final List<VideoModel> videos
  final List<VideoModel> userVideo;
  final PlaylistModel playlistModel;

  @override
  State<PlaylistVideosScreen> createState() => _PlaylistVideosScreenState();
}

class _PlaylistVideosScreenState extends State<PlaylistVideosScreen> {
  @override
  void initState() {
    context
        .read<FetchPlaylistVideosCubit>()
        .fetchPlaylistVideos(widget.playlistModel.videos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        title: const AppBarText(text: 'Videos'),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          log(widget.userVideo.length.toString());
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => PlaylistAddVideoScreen(
                    userVideo: widget.userVideo,
                    playlistModel: widget.playlistModel,
                  )));
        },
        child: CustomContainer(
          height: 40,
          width: 80,
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: CustomText(
                text: 'Add videos',
                color: AppColors.backgroundColor,
                fontSize: 10,
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: BlocBuilder<FetchPlaylistVideosCubit, FetchPlaylistVideosState>(
        builder: (context, state) {
          if (state is FetchPlaylistVideosLoadingState) {
            return const LoadingWidget();
          }
          if (state is FetchedPlaylistVideosState) {
            return VideosWidget(videos: state.playlistVideos);
          }
          return const NoDataWidget();
        },
      ),
    );
  }
}
