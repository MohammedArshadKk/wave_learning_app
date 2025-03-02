part of 'video_uploading_bloc.dart';

@immutable
abstract class VideoUploadingEvent {}

class PickVideoEvent extends VideoUploadingEvent {}

class ResetStateEvent extends VideoUploadingEvent {}

class PickThumbnailEvent extends VideoUploadingEvent {}

class GenerateThumbnailesEvent extends VideoUploadingEvent {
  final String videoPath;

  GenerateThumbnailesEvent({required this.videoPath});
}

class UploadVideoEvent extends VideoUploadingEvent {
  final VideoModel videoModel;
  final String thumbnailPath;
  final String videoPath;

  UploadVideoEvent({
    required this.videoModel,
    required this.thumbnailPath,
    required this.videoPath,
  });
}
