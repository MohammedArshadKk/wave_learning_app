import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/services/repositories/notification/notification_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() async {
  Workmanager().executeTask(
    (taskName, inputData) async {
      try {
        await Firebase.initializeApp();
        log('Firebase initialized successfully.');
      } catch (e) {
        log('Firebase initialization failed: $e');
        return Future.value(false);
      }

      if (taskName == 'videoUploadTask') {
        final id = inputData!['id'] as String;
        final videoPath = inputData['videoPath'] as String;
        final thumbnailPath = inputData['thumbnailPath'] as String;
        final videoModel = VideoModel(
          title: inputData['title'] as String,
          description: inputData['description'] as String,
          uid: inputData['uid'] as String,
          channelName: inputData['channelName'] as String,
          email: inputData['email'] as String,
          likes: (inputData['likes'] as List).cast<String>(),
          videoUrl: inputData['videoUrl'] as String,
          thumbnailUrl: inputData['thumbnailUrl'] as String,
          time: inputData['time'] as String,
          tags: (inputData['tags'] as List?)?.cast<String>(),
          watchLater: (inputData['watchLater']as List).cast<String>(),
        );

        try {
          final videoRef = FirebaseStorage.instance.ref('videos/$id.mp4');
          final uploadVideotask = videoRef.putFile(File(videoPath));

          uploadVideotask.snapshotEvents.listen((event) async {
            final progress = event.bytesTransferred / event.totalBytes;
            final progressPercentage = (progress * 100).round();

            await NotificationService().showProgressNotification(
                int.parse(id),
                'Uploading Video',
                'Progress: $progressPercentage%',
                progressPercentage);

            log('Upload progress: $progressPercentage% for id: $id');
          });

          final videoSnapshot = await uploadVideotask;
          final videoUrl = await videoSnapshot.ref.getDownloadURL();
          log('Video upload task completed: $videoUrl');

          final thumbnailRef =
              FirebaseStorage.instance.ref().child('thumbnails/$id.jpg');
          final thumbnailUploadTask = thumbnailRef.putFile(File(thumbnailPath));
          final thumbnailSnapshot = await thumbnailUploadTask;
          final thumbnailUrl = await thumbnailSnapshot.ref.getDownloadURL();
          log('Thumbnail upload task completed: $thumbnailUrl');

          videoModel.videoUrl = videoUrl;
          videoModel.thumbnailUrl = thumbnailUrl;
          videoModel.time = DateTime.now().toString();

          await FirebaseFirestore.instance
              .collection('channelVideos')
              .doc()
              .set(videoModel.toMap());

          await NotificationService().showProgressNotification(
            int.parse(id),
            'Video Upload Complete',
            'Your video has been uploaded successfully',
            100,
          );

          return Future.value(true);
        } catch (e) {
          log(e.toString());
          await NotificationService().showProgressNotification(
            int.parse(id),
            'Upload Failed',
            'An error occurred while uploading your video',
            0,
          );
          return Future.value(false);
        }
      }
      return Future.value(true);
    },
  );
}
