import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/channel_side_playlist_video_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/playlist_list.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_playlist_cubit/fetch_playlist_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_playlist_videos/fetch_playlist_videos_cubit.dart';

class ChannelSidePlaylistScreen extends StatefulWidget {
  const ChannelSidePlaylistScreen({super.key, required this.channelUid});
  final String channelUid;

  @override
  State<ChannelSidePlaylistScreen> createState() =>
      _ChannelSidePlaylistScreenState();
}

class _ChannelSidePlaylistScreenState extends State<ChannelSidePlaylistScreen> {
  @override
  void initState() {
    context
        .read<FetchPlaylistCubit>()
        .getChannelsidePlaylists(widget.channelUid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<FetchPlaylistCubit, FetchPlaylistState>(
        builder: (context, state) {
          if (state is PickingLoadingState) {
            return const LoadingWidget();
          } else if (state is Noplaylists) {
            return const NoDataWidget();
          } else if (state is PickedPlaylists) {
            return PlaylistList(
              playlists: state.playlists,
              onTap: (playlist) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return BlocProvider(
                    create: (context) => FetchPlaylistVideosCubit(),
                    child:  ChannelSidePlaylistVideoScreen(playlistVideos: playlist,),
                  );
                }));
              },
            );
          }
          return const NoDataWidget();
        },
      ),
    );
  }
}
