part of 'video_upload_background_cubit.dart';

@immutable
abstract class VideoUploadBackgroundState {}

final class VideoUploadBackgroundInitial extends VideoUploadBackgroundState {}

class UploadVideoState extends VideoUploadBackgroundState {
final  Map<String , UploadModel> uploads;
  UploadVideoState(this.uploads);
}