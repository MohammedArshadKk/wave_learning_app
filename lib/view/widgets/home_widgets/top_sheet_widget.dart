import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/video_upload_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/widgets/home_widgets/channel_not_created_alert_box.dart';
import 'package:wave_learning_app/view/widgets/home_widgets/create_meeting_widget.dart';
import 'package:wave_learning_app/view/widgets/home_widgets/upload_video_widget.dart';
import 'package:wave_learning_app/view_model/blocs/check%20channel%20created%20or%20not/channel_created_or_not_bloc.dart';

class TopSheetWidget extends StatelessWidget {
  TopSheetWidget({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 250,
      width: double.infinity,
      borderRadius: BorderRadius.circular(20),
      color: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<ChannelCreatedOrNotBloc, ChannelCreatedOrNotState>(
                listener: (context, state) {
                  if (state is ChannelCreatedState) {
                    log('good');
                  } else if (state is ChannelNotCreatedState) {
                    // Navigator.pop(context);
                    channelNotCreatedAlertBox(context);
                  }
                },
                child: UploadVideoWidget(
                  uid: _auth.currentUser!.uid,
                ),
              ),
              const SizedBox(width: 40),
              BlocListener<ChannelCreatedOrNotBloc, ChannelCreatedOrNotState>(
                listener: (context, state) {
                  if (state is ChannelCreatedState) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> VideoUploadScreen()));
                  } else if (state is ChannelNotCreatedState) {
                    channelNotCreatedAlertBox(context);
                  }
                },
                child: CreateMeetingWidget(uid: _auth.currentUser!.uid),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
