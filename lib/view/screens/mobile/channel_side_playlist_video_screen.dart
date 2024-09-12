import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/playlist_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/videos_widget.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_playlist_videos/fetch_playlist_videos_cubit.dart';

class ChannelSidePlaylistVideoScreen extends StatefulWidget {
  const ChannelSidePlaylistVideoScreen({super.key, required this.playlistVideos});
  final PlaylistModel playlistVideos;
  @override
  State<ChannelSidePlaylistVideoScreen> createState() => _ChannelSidePlaylistVideoScreenState();
}

class _ChannelSidePlaylistVideoScreenState extends State<ChannelSidePlaylistVideoScreen> {
  @override
  void initState() {
    context.read<FetchPlaylistVideosCubit>().fetchPlaylistVideos(widget.playlistVideos.videos);
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