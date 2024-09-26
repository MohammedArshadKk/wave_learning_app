import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class VideoUploadingFields extends StatelessWidget {
  const VideoUploadingFields(
      {super.key,
      required this.titleController,
      required this.videoDescriptionController,
      required this.tagsController,
      required this.formKey});

  final TextEditingController titleController;
  final TextEditingController videoDescriptionController;
  final TextEditingController tagsController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'Enter video title',
            fontFamily: Fonts.primaryText,
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
            labelText: 'Enter description',
            fontFamily: Fonts.primaryText,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, bottom: 8),
                child: CustomText(
                  text: 'Enter a comma after each tag',
                  color: AppColors.secondaryColor,
                  fontSize: 12,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomTextFormField(
                labelText: 'Enter tags',
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.normal,
                padding: 20,
                fontSize: 12,
                textColor: AppColors.lightTextColor,
                paddingForm: 30,
                borderRadius: 12,
                controller: tagsController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
