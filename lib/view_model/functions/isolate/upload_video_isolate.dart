import 'dart:io';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/firebase_options.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: false,
    ),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance serviceInstance) async {
  log("Background service starting...");

  bool isUploading = false;
  String? currentUploadId;

  // Initialize Firebase
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      log("Firebase initialized in background service");
    }
  } catch (e) {
    log("Firebase initialization error: $e");
    await serviceInstance.stopSelf();
    return;
  }

  serviceInstance.on('stopService').listen((event) async {
    log("Stop service requested");
    if (!isUploading) {
      await serviceInstance.stopSelf();
    }
  });

  serviceInstance.on('startUpload').listen((event) async {
    if (isUploading) {
      log("Upload already in progress. Skipping new request.");
      return;
    }

    String? filePath = event?["filePath"];
    String? docId = event?['docId'];

    log("filePath: $filePath, docId: $docId");

    if (filePath == null ||
        docId == null ||
        filePath.isEmpty ||
        docId.isEmpty) {
      log("Invalid upload parameters received");
      return;
    }
    final db = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance; 
    try {
      isUploading = true;
      currentUploadId = docId;

      final file = File(filePath);

      if (!file.existsSync()) {
        throw Exception("Video file not found at path: $filePath");
      }

      await db.collection('channelVideos').doc(docId).update({
        'uploadStatus': 'starting',
        'progress': '0',
        'error': null,
      });

      final fileName = "video_${DateTime.now().millisecondsSinceEpoch}.mp4";
      final ref = storage.ref().child("videos/$fileName");

      log("Starting upload for file: $fileName");

      final metadata = SettableMetadata(
          contentType: 'video/mp4',
          customMetadata: {'uploadTime': DateTime.now().toIso8601String()});

      final uploadTask = ref.putFile(file, metadata);

      uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) async {
          if (!isUploading) return; 

          double progress = snapshot.bytesTransferred / snapshot.totalBytes;
          int percentage = (progress * 100).round();

          log("Upload progress: $percentage%");

          await db.collection('channelVideos').doc(docId).update({
            'progress': percentage.toString(),
            'uploadStatus': 'uploading',
          }).catchError((error) {
            log("Error updating progress: $error");
          });
        },
        onError: (error) async {
          log("Upload error: $error");
          await handleError(db, docId, error.toString(), serviceInstance);
          isUploading = false;
          currentUploadId = null;
        },
        cancelOnError: true,
      );

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await db.collection('channelVideos').doc(docId).update({
        'videoUrl': downloadUrl,
        'isUploaded': true,
        'uploadStatus': 'completed',
        'progress': '100',
        'completedAt': FieldValue.serverTimestamp(),
      });

      log("Upload completed successfully. URL: $downloadUrl");

      serviceInstance.invoke('uploadComplete', {
        'downloadUrl': downloadUrl,
        'docId': docId,
      });
    } catch (e) {
      log("Upload process error: $e");
      await handleError(db, docId, e.toString(), serviceInstance);
    } finally {
      isUploading = false;
      currentUploadId = null;
    }
  });
}

Future<void> handleError(FirebaseFirestore db, String docId, String error,
    ServiceInstance service) async {
  try {
    await db.collection('channelVideos').doc(docId).update({
      'error': error,
      'isUploaded': false,
      'uploadStatus': 'failed',
      'failedAt': FieldValue.serverTimestamp(),
    });
    log("Error handled: $error");
  } catch (e) {
    log("Error in handleError: $e");
  }
}

Future<void> startUpload(String filePath, String docId) async {
  try {
    final service = FlutterBackgroundService();

    log("Starting background service for upload...");

    final isRunning = await service.isRunning();
    if (!isRunning) {
      await service.startService();
      await Future.delayed(const Duration(seconds: 2));
    }

    log("Invoking startUpload with path: $filePath, docId: $docId");
    service.invoke('startUpload', {
      'filePath': filePath,
      'docId': docId,
    });
    service.on('uploadComplete').listen((event) {
      log("Upload completed event received: ${event.toString()}");
    });
  } catch (e) {
    log("Error starting upload service: $e");
    rethrow;
  }
}

Future<void> stopUploadService() async {
  final service = FlutterBackgroundService();
  service.invoke('stopService');
}