import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/services/repositories/background_service/background_service.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/generate_thumbnail.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/pick_video.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/pike_thumbnail.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/upolad_thumbnail.dart';
part 'video_uploading_event.dart';
part 'video_uploading_state.dart';

class VideoUploadingBloc
    extends Bloc<VideoUploadingEvent, VideoUploadingState> {
  List<Map<String, dynamic>> currentUploads = [];

  VideoUploadingBloc() : super(VideoUploadingInitial()) {
    on<PickVideoEvent>(pickVideoEvent);
    on<ResetStateEvent>(resetStateEvent);
    on<PickThumbnailEvent>(pickThumbnailEvent);
    on<GenerateThumbnailesEvent>(generateThumbnailsEvent);
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

  FutureOr<void> generateThumbnailsEvent(
      GenerateThumbnailesEvent event, Emitter<VideoUploadingState> emit) async {
    try {
      emit(VideoPikingLoadingState());
      final thumbnail = await generateThumbnail(event.videoPath);
      emit(ThumbnailGeneratedState(thumbnail: thumbnail));
    } catch (e) {
      log(e.toString());
      emit(VideoPikingerrorState(error: e.toString()));
    }
  }

  FutureOr<void> uploadVideoEvent(
      UploadVideoEvent event, Emitter<VideoUploadingState> emit) async {
    try {
      emit(VideoUploadLoadingState());
      // upolad thumbmail
      final thumbmailUrl = await thumbnailUploadTostrage(
          File(event.thumbnailPath), event.videoModel);
      event.videoModel.thumbnailUrl = thumbmailUrl!;
      // store video details
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('channelVideos').doc();
      String documentId = docRef.id;
      await docRef.set(event.videoModel.toMap());
      log(documentId);
      emit(VideodetailsUploadedState());
      // upload video in background
      await startUpload(event.videoPath, documentId);
    } catch (e) {
      log(e.toString());
    }
  }
}