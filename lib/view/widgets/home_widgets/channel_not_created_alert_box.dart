import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:wave_learning_app/view/screens/mobile/create_channel_screen.dart';

channelNotCreatedAlertBox(BuildContext context) {
  PanaraConfirmDialog.show(context,
      message: 'Channel not created',
      confirmButtonText: 'Create',
      cancelButtonText: 'Cancel', onTapConfirm: () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const CreateChannelScreen(text: 'create')));
  }, onTapCancel: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.error);
}
