import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferenceScreen extends StatelessWidget {
  const VideoConferenceScreen(
      {super.key,
      required this.conferenceID,
      required this.uid,
      required this.appSign,
      required this.appID});
  final String conferenceID;
  final String uid;
  final String appSign;
  final int appID;
  @override
  Widget build(BuildContext context) {
    // log(appSign); 
    // log(appID.toString());

    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
          appID: appID,
          appSign: appSign,
          conferenceID: conferenceID,
          userID: uid,
          userName: 'userName',
          config: ZegoUIKitPrebuiltVideoConferenceConfig()),
    );
  }
}
