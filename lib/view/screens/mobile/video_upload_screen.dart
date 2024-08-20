import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/add_thumbnail_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_button.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/app_bar_title.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/video_player_widget.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/video_upload_image_widget.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/video_uploading_fileds.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';

class VideoUploadScreen extends StatelessWidget {
  VideoUploadScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoDescriptionController =
      TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    File? videoUrl;
    return PopScope(
      onPopInvoked: (didPop) async {
        context.read<VideoUploadingBloc>().add((ResetStateEvent()));
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: const AppBarTitle(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<VideoUploadingBloc, VideoUploadingState>(
                builder: (context, state) {
                  if (state is VideoPikedState) {
                    videoUrl = state.videoPath;
                    return VideoPlayerWidget(videoFile: state.videoPath);
                  } else if (state is VideoPikingLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is VideoPikingerrorState) {
                    return const Center(
                      child: Text('errror'),
                    );
                  } else {
                    return const VideoUploadImageWidget();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              VideoUploadingFileds(
                titleController: titleController,
                videoDescriptionController: videoDescriptionController,
                tagsController: tagsController,
                formKey: formKey,
              ),
              InkWell(
                
                onTap: () {
                  log(tagsController.text);
                  log(tagsController.text);
                  if (videoUrl == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColors.alertColor,
                        content: const Text('Please upload video')));
                  } else {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AddThumbnailScreen(
                                titleController: titleController,
                                videoDescriptionController:
                                    videoDescriptionController,
                                tagsController: tagsController,
                                videoFile: videoUrl!,
                              )));
                    }
                  }
                },
                child: const CustomButton(
                  text: 'next',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
