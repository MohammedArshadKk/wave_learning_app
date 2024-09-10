import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/blocs/channel%20createtion%20bloc/channel_creation_bloc.dart';

class CreateButton extends StatelessWidget {
  CreateButton({
    super.key,
    required this.formKey,
    required this.channelNameController,
    required this.descriptionController,
    required this.subjectController,
    required this.text,
    required this.documentid,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController channelNameController;
  final TextEditingController descriptionController;
  final TextEditingController subjectController;
  final String text;
  final String documentid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    File? icon;
    return BlocListener<ChannelCreationBloc, ChannelCreationState>(
      listener: (context, state) {
        if (state is PickedIconState) {
          icon = state.channelIcon;
        }
      },
      child: GestureDetector(
        onTap: () {
          if (icon == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColors.alertColor,
                content: const Text('Please add a channel icon')));
          } else {
            if (formKey.currentState!.validate()) {
              final channel = ChannelModel(
                channelName: channelNameController.text,
                email: _auth.currentUser!.email.toString(),
                uid: _auth.currentUser!.uid,
                description: descriptionController.text,
                focusedSubject: subjectController.text,
                members: [],
              );
              if (text == 'edit') {
                context.read<ChannelCreationBloc>().add(
                      ChannelEditEvent(
                        channel,
                        documentid.toString(),
                        channelIcon: icon,
                      ),
                    );
              } else {
                context.read<ChannelCreationBloc>().add(
                      CreateButtonclickedEvent(
                        channel,
                        channelIcon: icon,
                      ),
                    );
              }
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: CustomContainer(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width,
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: CustomText(
                text: text,
                color: AppColors.backgroundColor,
                fontSize: 20,
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
