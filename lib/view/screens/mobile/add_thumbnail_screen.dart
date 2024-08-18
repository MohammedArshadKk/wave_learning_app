import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/sam.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_button.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/add_thumbnail_widget.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/app_bar_title.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/check_box_widget.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';
import 'package:workmanager/workmanager.dart';

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const AppBarTitle(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AddThumbnailWidget(),
          const CheckBoxWidget(),
          GestureDetector(
            onTap: () async {
              // log(videoFile.path);
              // context
              //     .read<VideoUploadingBloc>()
              //     .add(UploadVideoEvent(File('path'),titleController.text, videoFile: videoFile));
              Workmanager().registerOneOffTask(
                'videoUploadTask',
                'uploadVideo',
                inputData: {
                  'title': titleController.text,
                  'videoPath': videoFile.path,
                },
              );
              Navigator.of(context)  
                  .push(MaterialPageRoute(builder: (ctx) => UploadPage()));
            },
            child: const CustomButton(
              text: 'upload video',
            ),
          ),
        ],
      ),
    );
  }
}
