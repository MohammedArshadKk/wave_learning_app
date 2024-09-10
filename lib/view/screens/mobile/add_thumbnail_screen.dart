import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_button.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/add_thumbnail_widget.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/app_bar_title.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/check_box_widget.dart';
import 'package:wave_learning_app/view_model/cubits/background_service_cubit/video_upload_background_cubit.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';

class AddThumbnailScreen extends StatelessWidget {
  const AddThumbnailScreen(
      {super.key,
      required this.titleController,
      required this.videoDescriptionController,
      required this.tagsController,
      required this.videoFile});
  final TextEditingController titleController;
  final TextEditingController videoDescriptionController;
  final TextEditingController tagsController;
  final File videoFile;

  @override
  Widget build(BuildContext context) {
    File? thumbnail;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const AppBarTitle(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<VideoUploadingBloc, VideoUploadingState>(
            listener: (context, state) {
              if (state is ThumbnailPikedState) {
                thumbnail = state.thumbnailPath;
              } else if (state is VideoPikingLoadingState) {
                customLoading(context);
              } else if (state is ThumbnailGeneratedState) {
                Navigator.pop(context);
                thumbnail = File(state.thumbnail);
                _startUpload(context, thumbnail!, videoFile);
              }
            },
            child: const AddThumbnailWidget(),
          ),
          const CheckBoxWidget(),
          GestureDetector(
            onTap: () async {
              if (thumbnail == null) {
                context
                    .read<VideoUploadingBloc>()
                    .add(GenerateThumbnailesEvent(videoPath: videoFile.path));
              } else {
                _startUpload(context, thumbnail!, videoFile);
              }
            },
            child: const CustomButton(
              text: 'upload video',
            ),
          ),
        ],
      ),
    );
  }

  void _startUpload(BuildContext context, File thumbnail, File videoFile) {
    final cubit = context.read<VideoUploadBackgroundCubit>();

    final tagsText = tagsController.text;
    final tags = tagsText.trim().split(',').toList();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final videoModel = VideoModel(
        title: titleController.text,
        description: videoDescriptionController.text,
        tags: tags,
        uid: auth.currentUser!.uid,
        channelName: 'channelName',
        email: auth.currentUser!.email.toString(),
        likes: [],
        videoUrl: '',
        thumbnailUrl: '',
        time: DateTime.now().toString(),
        watchLater: [],
        views: [], 
        );

    cubit.startUpload(videoFile.path, thumbnail.path, videoModel);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
