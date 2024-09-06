import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/playlist_model.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/create_playlist_cubit/create_playlist_cubit.dart';
import 'package:wave_learning_app/view_model/functions/calculate_time_diff.dart';

class PlaylistAddVideoScreen extends StatefulWidget {
  const PlaylistAddVideoScreen(
      {super.key, required this.userVideo, required this.playlistModel});
  final List<VideoModel> userVideo;
  final PlaylistModel playlistModel;

  @override
  // ignore: library_private_types_in_public_api
  _PlaylistAddVideoScreenState createState() => _PlaylistAddVideoScreenState();
}

class _PlaylistAddVideoScreenState extends State<PlaylistAddVideoScreen> {
  List<String> selectedVideos = []; 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePlaylistCubit, CreatePlaylistState>(
      listener: (context, state) {
        if (state is AddingLoadingState) {
          customLoading(context);
        } else if (state is AddedState) {
          Navigator.pop(context);
          context
              .read<CreatePlaylistCubit>()
              .getPlaylists(_auth.currentUser!.uid);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(color: AppColors.backgroundColor),
          title: const AppBarText(text: 'Add video'),
          toolbarHeight: 100,
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            final VideoModel video = widget.userVideo[index];
            String difference = calculateTimeDiff(video.time);
            String title = video.title;
            if (title.length > 16) {
              title = "${title.substring(0, 15)}..";
            }

            bool isSelected = selectedVideos.contains(video.documentid);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.primaryColor,
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedVideos.add(video.documentid.toString());
                        } else {
                          selectedVideos.remove(video.documentid);
                        }
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomContainer(
                      height: 100,
                      width: 180,
                      color: AppColors.backgroundColor,
                      borderColor: Border.all(color: AppColors.lightTextColor),
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        video.thumbnailUrl,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: title,
                          color: AppColors.secondaryColor,
                          fontSize: 18,
                          fontFamily: Fonts.labelText,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text: difference.toString(),
                          color: AppColors.secondaryColor,
                          fontSize: 17,
                          fontFamily: Fonts.labelText,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.thumb_up_alt_outlined),
                            const SizedBox(width: 5),
                            CustomText(
                              text: video.likes.length.toString(),
                              color: AppColors.secondaryColor,
                              fontSize: 17,
                              fontFamily: Fonts.labelText,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(15.0),
              child: Divider(),
            );
          },
          itemCount: widget.userVideo.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<CreatePlaylistCubit>().addVideosToPlaylist(
                selectedVideos, widget.playlistModel.documentId.toString());
            log('Selected videos: ${selectedVideos.length}');
          },
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.check, color: AppColors.backgroundColor),
        ),
      ),
    );
  }   
}
