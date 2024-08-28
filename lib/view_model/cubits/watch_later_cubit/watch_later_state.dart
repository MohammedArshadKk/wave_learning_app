part of 'watch_later_cubit.dart';

@immutable
sealed class WatchLaterState {}

final class WatchLaterInitial extends WatchLaterState {}

class AddedwatchLaterState extends WatchLaterState {}

class RemovedwatchLaterState extends WatchLaterState {}

class PickedWatchLaterVideos extends WatchLaterState {
  final List<VideoModel> videoModel;

  PickedWatchLaterVideos({required this.videoModel});
}

class WatchLaterLoadingState extends WatchLaterState {}

class NoVideosState extends WatchLaterState {}
