part of 'video_uploading_bloc.dart';

@immutable
sealed class VideoUploadingState {}

final class VideoUploadingInitial extends VideoUploadingState {}

class VideoPikedState extends VideoUploadingState {
  final File videoPath;
  VideoPikedState({required this.videoPath});
}

class VideoPikingLoadingState extends VideoUploadingState {}

class VideoPikingerrorState extends VideoUploadingState {
  final String error;

  VideoPikingerrorState({required this.error});
}

class ThumbnailPikedState extends VideoUploadingState {
  final File thumbnailPath;
  ThumbnailPikedState({required this.thumbnailPath});
}

class ThumbnailGeneratedState extends VideoUploadingState {
  final String thumbnail;
  ThumbnailGeneratedState({required this.thumbnail});
}
