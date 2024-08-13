import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class VideoUploadingFileds extends StatelessWidget {
  const VideoUploadingFileds(
      {super.key,
      required this.titleController,
      required this.videoDescriptionController,
      required this.tagsController});
  final TextEditingController titleController;
  final TextEditingController videoDescriptionController;
  final TextEditingController tagsController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          labelText: 'Enter video title',
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
          padding: 20,
          fontSize: 12,
          textColor: AppColors.lightTextColor,
          paddingForm: 30,
          borderRadius: 12,
          controller: titleController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter title';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          labelText: 'Enter your channel description',
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
          padding: 20,
          fontSize: 12,
          textColor: AppColors.lightTextColor,
          paddingForm: 30,
          borderRadius: 12,
          controller: videoDescriptionController,
        
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          labelText: 'Enter channel focused subject',
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
          padding: 20,
          fontSize: 12,
          textColor: AppColors.lightTextColor,
          paddingForm: 30,
          borderRadius: 12,
          controller: tagsController,
        ),
      ],
    );
  }
}
