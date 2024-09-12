import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/screens/mobile/playlist_videos_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/create_playlist_bottom_sheet.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/playlist_list.dart';
import 'package:wave_learning_app/view_model/cubits/create_playlist_cubit/create_playlist_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_playlist_videos/fetch_playlist_videos_cubit.dart';

class PlaylistWidget extends StatefulWidget {
  const PlaylistWidget({super.key, required this.userVideo});
  final List<VideoModel> userVideo;
  @override
  State<PlaylistWidget> createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  final TextEditingController playlistNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    log(widget.userVideo.length.toString());
    final playlist = context.read<CreatePlaylistCubit>();
    playlist.getPlaylists(_auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.playlist_add,
          color: AppColors.backgroundColor,
        ),
        onPressed: () {
          showModelBottomSheet(
              context, playlistNameController, _auth.currentUser!.uid);
        },
      ),
      body: BlocBuilder<CreatePlaylistCubit, CreatePlaylistState>(
        builder: (context, state) {
          if (state is PickingLoadingState) {
            return const LoadingWidget();
          } else if (state is Noplaylists) {
            return const NoDataWidget();
          } else if (state is PickedPlaylists) {
            return PlaylistList(
              playlists: state.playlists,
              userVideo: widget.userVideo,
              onTap: (playlist) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => BlocProvider(
                    create: (context) => FetchPlaylistVideosCubit(),
                    child: PlaylistVideosScreen(
                      userVideo: widget.userVideo,
                      playlistModel: playlist,
                    ),
                  ),
                ));
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
