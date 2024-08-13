import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_button.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/app_bar_title.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/video_upload_image_widget.dart';
import 'package:wave_learning_app/view/widgets/video_upload_widgets/video_uploading_fileds.dart';

class VideoUploadScreen extends StatelessWidget {
  VideoUploadScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoDescriptionController =
      TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const AppBarTitle(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VideoUploadImageWidget(),
            const SizedBox(
              height: 30,
            ),
            VideoUploadingFileds(
                titleController: titleController,
                videoDescriptionController: videoDescriptionController,
                tagsController: tagsController),
            InkWell(
              onTap: () {
                
              },
              child: const CustomButton(
                text: 'next',
              ),
            )
          ],
        ),
      ),
    );
  }
}
