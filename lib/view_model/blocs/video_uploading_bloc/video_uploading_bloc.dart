import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/pick_video.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/pike_thumbnail.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/save_video_details_to_prefs.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/upload_video_in_isolate.dart';
part 'video_uploading_event.dart';
part 'video_uploading_state.dart';

class VideoUploadingBloc
    extends Bloc<VideoUploadingEvent, VideoUploadingState> {
  List<Map<String, dynamic>> currentUploads = []; 

  VideoUploadingBloc() : super(VideoUploadingInitial()) {
    on<PickVideoEvent>(pickVideoEvent);
    on<ResetStateEvent>(resetStateEvent);
    on<PickThumbnailEvent>(pickThumbnailEvent);
    on<UploadVideoEvent>(uploadVideoEvent);
  }

  FutureOr<void> pickVideoEvent(
      PickVideoEvent event, Emitter<VideoUploadingState> emit) async {
    try {
      emit(VideoPikingLoadingState());
      final result = await pickVideo();
      if (result != null) {
        log(result.files.single.path!);
        emit(VideoPikedState(videoPath: File(result.files.single.path!)));
      } else {
        log('not picked');
      }
    } catch (e) {
      emit(VideoPikingerrorState(error: e.toString()));
    }
  }

  FutureOr<void> resetStateEvent(
      ResetStateEvent event, Emitter<VideoUploadingState> emit) {
    emit(VideoUploadingInitial());
  }

  FutureOr<void> pickThumbnailEvent(
      PickThumbnailEvent event, Emitter<VideoUploadingState> emit) async {
    try {
      final result = await pickThumbnail();
      if (result != null) {
        emit(ThumbnailPikedState(thumbnailPath: File(result.path)));
      } else {
        log('not picked');
      }
    } catch (e) {
      emit(VideoPikingerrorState(error: e.toString()));
    }
  }

 FutureOr<void> uploadVideoEvent(
  UploadVideoEvent event, Emitter<VideoUploadingState> emit) async {
  try {
    emit(UploadLoadingState());

    await saveVideoDetailsToPrefs(
        event.title, event.videoFile.path, event.thumbnail.path);

    // Add the new upload to the list
    currentUploads.add({
      'title': event.title,
      'videoPath': event.videoFile.path,
      'thumbnailPath': event.thumbnail.path,
      'progress': 0.0,
    });

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    await Isolate.spawn(uploadVideoInIsolate, [
      event.videoFile.path,
      event.title,
      event.thumbnail.path,
      sendPort,
      Firebase.app().options,
      RootIsolateToken.instance!,
    ]);

    await for (var message in receivePort) {
      if (message is Map) {
        if (message.containsKey('progress')) {
          final uploadIndex = currentUploads.indexWhere((upload) => upload['videoPath'] == message['videoPath']);
          if (uploadIndex != -1) {
            currentUploads[uploadIndex]['progress'] = message['progress'];
            emit(UpdateProgressState(uploads: List.from(currentUploads)));
          }
        } else if (message.containsKey('completed')) {
          currentUploads.removeWhere((upload) => upload['videoPath'] == message['videoPath']);
          emit(UpdateProgressState(uploads: List.from(currentUploads)));
          if (currentUploads.isEmpty) {
            emit(UploadCompletedState());
          }
        } else if (message.containsKey('error')) {
          final uploadIndex = currentUploads.indexWhere((upload) => upload['videoPath'] == message['videoPath']);
          if (uploadIndex != -1) {
            currentUploads.removeAt(uploadIndex);
          }
          emit(UpdateProgressState(uploads: List.from(currentUploads)));
          emit(UploadFailedState(error: message['error']));
        }
      }
    }
  } catch (e) {
    emit(UploadFailedState(error: 'Failed to upload video: ${e.toString()}'));
  }  
}
}
