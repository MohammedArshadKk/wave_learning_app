import 'dart:developer';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> startUpload(String filePath, String docId) async {
  try {
    final service = FlutterBackgroundService();

    log("Starting background service for upload...");

    service.on('uploadComplete').listen((event) {
      log("Upload completed event received: ${event.toString()}");
    });
    
    service.on('uploadError').listen((event) {
      log("Upload error event received: ${event.toString()}");
    });

    final isRunning = await service.isRunning();
    if (!isRunning) {
      await service.startService();
      
      log("Waiting for service to initialize...");
      await Future.delayed(const Duration(seconds: 3));
    }

    final isRunningAfterDelay = await service.isRunning();
    if (!isRunningAfterDelay) {
      throw Exception("Background service failed to start after delay");
    }

    log("Invoking startUpload with path: $filePath, docId: $docId");
    service.invoke('startUpload', {
      'filePath': filePath,
      'docId': docId,
    });

  } catch (e) {
    log("Error starting upload service: $e");
    rethrow;
  }
} 