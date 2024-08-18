import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Log the start of the task
    log('[WORKMANAGER] Task started');
    await Firebase.initializeApp();

    try {
        await Firebase.initializeApp();
      log('[WORKMANAGER] Firebase initialized');

      final title = inputData!['title'];
      final videoPath = inputData['videoPath'];
      log('[WORKMANAGER] Title: $title, Video Path: $videoPath');

      final reference = FirebaseStorage.instance.ref().child('videos/$title');
      log('[WORKMANAGER] Reference created');

      final uploadTask = reference.putFile(File(videoPath));
      log('[WORKMANAGER] Upload task created');

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        log('[WORKMANAGER] Upload progress: $progress');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setDouble('uploadProgress', progress);
      });

      await uploadTask.whenComplete(() {
        log('[WORKMANAGER] Upload completed');
      });

      // Log the success of the task
      log('[WORKMANAGER] Task completed successfully');
      await uploadTask.whenComplete(() {});
      return Future.value(true);
    } catch (e) {
      // Log any errors that occur during the task
      log('[WORKMANAGER] Error occurred: $e');
      return Future.value(false);
    }
  });
}
