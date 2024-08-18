import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<void> uploadVideoInIsolate(List args) async {
  String videoPath = args[0];
  String title = args[1];
  String thumbnailPath = args[2];
  SendPort sendPort = args[3];
  final options = args[4];

  try {
    log('Initializing Firebase');
    BackgroundIsolateBinaryMessenger.ensureInitialized(args[5]);
    await Firebase.initializeApp(options: options);

    FirebaseStorage storage = FirebaseStorage.instance;
    File videoFile = File(videoPath);
    String fileName = DateTime.now().toString();
    Reference ref = storage.ref().child('videos/$fileName');
    UploadTask uploadTask = ref.putFile(videoFile);

    // Periodically check and send progress updates
    while (uploadTask.snapshot.state == TaskState.running) {
      TaskSnapshot snapshot = uploadTask.snapshot;
      double progress=0.0;
      if (uploadTask.snapshot.totalBytes != 0) {
         progress = uploadTask.snapshot.bytesTransferred /
            uploadTask.snapshot.totalBytes;    
        log('Upload progress: $progress');
      } else {
        log('Upload progress: unknown');
      }
      sendPort.send({
        'progress': progress,
        'videoPath': videoPath,
        'title': title,
        'thumbnailPath': thumbnailPath,
      });
      await Future.delayed(const Duration(   
          milliseconds:
              500)); // Wait for 500ms before checking again// Wait for a second before checking again
    }

    // Check final status
    TaskSnapshot finalSnapshot = await uploadTask;
    if (finalSnapshot.state == TaskState.success) {
      sendPort.send({
        'completed': true,
        'videoPath': videoPath,
        'title': title,
        'thumbnailPath': thumbnailPath,
      });
      log('Upload completed');
    } else {
      throw Exception('Upload failed: ${finalSnapshot.state}');
    }
  } catch (e) {
    sendPort.send({
      'error': e.toString(),
      'videoPath': videoPath,
      'title': title,
      'thumbnailPath': thumbnailPath,
    });
    log(e.toString());
  }
}
