part of 'get_channel_videos_cubit.dart';

@immutable
abstract class GetChannelVideosState {}

final class GetChannelVideosInitial extends GetChannelVideosState {}

class FetchingLoadingState extends GetChannelVideosState {}

class NoVideosState extends GetChannelVideosState {}

class VideoFetchedState extends GetChannelVideosState {
  final List<VideoModel> videos;

  VideoFetchedState({required this.videos});
}

class ErrorState extends GetChannelVideosState {}
