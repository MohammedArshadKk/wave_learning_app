import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view%20model/blocs/channel%20createtion%20bloc/channel_creation_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class CreateButton extends StatelessWidget {
  CreateButton({
    super.key,   
    required this.formKey,
    required this.channelName,
    required this.description,
    required this.subject,
    required this.text,
    required this.documentid,
    this.icon,
  });
  final File? icon;
  final GlobalKey<FormState> formKey;
  final String channelName;
  final String description;
  final String subject;
  final String text;
  final String documentid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return GestureDetector(
      onTap: () {
        if (icon == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.alertColor,
              content: const Text('Please add channel icon')));
        } else {
          if (formKey.currentState!.validate()) {
            final channel = ChannelModel(
              channelName: channelName,
              email: _auth.currentUser!.email.toString(),
              uid: _auth.currentUser!.uid,
              description: description,
              focusedSubject: subject,
            );
            if (text == 'edit') {
              context.read<ChannelCreationBloc>().add(ChannelEditEvent(
                  channel, documentid.toString(),
                  channelIcon: icon));
            } else {
              context
                  .read<ChannelCreationBloc>()
                  .add(CreateButtonclickedEvent(channel, channelIcon: icon));
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: CustomContainer(
          height: screenHeight * 0.07,
          width: screenWidth,
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: CustomText(
                text: text,
                color: AppColors.backgroundColor,
                fontSize: 20,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
