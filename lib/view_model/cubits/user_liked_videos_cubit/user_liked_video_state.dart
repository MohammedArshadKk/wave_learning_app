part of 'user_liked_video_cubit.dart';

@immutable
sealed class UserLikedVideoState {}

final class UserLikedVideoInitial extends UserLikedVideoState {}

class LoadingFetchUserLikedVideoState extends UserLikedVideoState {}

class FetchedLikedVideoState extends UserLikedVideoState {
  final List<VideoModel> videoModel;

  FetchedLikedVideoState({required this.videoModel});
}

class NoLikedVideo extends UserLikedVideoState {}

class ErrorState extends UserLikedVideoState{}
