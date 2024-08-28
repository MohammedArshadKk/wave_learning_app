part of 'get_all_videos_cubit.dart';

@immutable
abstract class GetAllVideosState {}

final class GetAllVideosInitial extends GetAllVideosState {}

class AllVideoFetchingLoadingState extends GetAllVideosState {}

class NoVideosState extends GetAllVideosState {}

class AllVideoFetchedState extends GetAllVideosState {
  final List<VideoModel> videos;

  AllVideoFetchedState({required this.videos});
}

class ErrorState extends GetAllVideosState {}
