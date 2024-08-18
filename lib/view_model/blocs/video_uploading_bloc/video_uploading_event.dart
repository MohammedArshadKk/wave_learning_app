part of 'video_uploading_bloc.dart';


@immutable
abstract class VideoUploadingEvent {}

class PickVideoEvent extends VideoUploadingEvent {}

class ResetStateEvent extends VideoUploadingEvent {}

class PickThumbnailEvent extends VideoUploadingEvent {}

class UploadVideoEvent extends VideoUploadingEvent {
  final File videoFile;
  final File thumbnail;
  final String title;
  UploadVideoEvent(this.thumbnail, this.title, {required this.videoFile});
}

class UpdateProgressEvent extends VideoUploadingEvent {
  final double progress;
  final String videoPath;
  final String title;
  final String thumbnail;

  UpdateProgressEvent({
    required this.progress,
    required this.videoPath,
    required this.title,
    required this.thumbnail,
  });
}


class UploadCompletedEvent extends VideoUploadingEvent {}

class UploadFailedEvent extends VideoUploadingEvent {}

