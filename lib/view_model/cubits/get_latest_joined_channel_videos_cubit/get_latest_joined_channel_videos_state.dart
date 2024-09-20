part of 'get_latest_joined_channel_videos_cubit.dart';

@immutable
abstract class GetLatestJoinedChannelVideosState {}

final class GetLatestJoinedChannelVideosInitial
    extends GetLatestJoinedChannelVideosState {}

class ErrorState extends GetLatestJoinedChannelVideosState {}

class LoadingGetLatestVideosState extends GetLatestJoinedChannelVideosState {}

class PikedState extends GetLatestJoinedChannelVideosState {
  final List<VideoModel> videos;

  PikedState({required this.videos});
}
