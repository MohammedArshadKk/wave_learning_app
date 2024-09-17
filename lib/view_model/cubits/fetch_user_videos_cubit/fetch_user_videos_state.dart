part of 'fetch_user_videos_cubit.dart';

@immutable
sealed class FetchUserVideosState {}

final class FetchUserVideosInitial extends FetchUserVideosState {}

class VideoFetchingLoadingState extends FetchUserVideosState {}

class VideoFetchedState extends FetchUserVideosState {
  final List<VideoModel> videos;

  VideoFetchedState({required this.videos});
}

class NoVideosState extends FetchUserVideosState {}

class ErrorState extends FetchUserVideosState {
  final String error;
  ErrorState(this.error);
}

class DeleteVideoState extends FetchUserVideosState {}
