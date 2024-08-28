import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ChannelCreateTextFormFiled extends StatelessWidget {
  const ChannelCreateTextFormFiled(
      {super.key,
      required this.channelNameController,
      required this.channelDescriptionController,
      required this.channelfocusedSubjectController});
  final TextEditingController channelNameController;
  final TextEditingController channelDescriptionController;
  final TextEditingController channelfocusedSubjectController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          labelText: 'Enter your channel name',
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
          padding: 20,
          fontSize: 12,
          textColor: AppColors.lightTextColor,
          paddingForm: 30,
          borderRadius: 12,
          controller: channelNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter channel name';
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
          controller: channelDescriptionController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter channel description';
            }
            return null;
          },
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
          controller: channelfocusedSubjectController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter channel focused subject ';
            }
            return null;
          },
        ),
      ],
    );
  }
}
