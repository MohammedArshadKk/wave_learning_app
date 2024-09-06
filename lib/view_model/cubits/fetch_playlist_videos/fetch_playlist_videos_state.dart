part of 'fetch_playlist_videos_cubit.dart';

@immutable
abstract class FetchPlaylistVideosState {}

final class FetchPlaylistVideosInitial extends FetchPlaylistVideosState {}

class FetchPlaylistVideosLoadingState extends FetchPlaylistVideosState {}

class FetchedPlaylistVideosState extends FetchPlaylistVideosState {
 final List<VideoModel> playlistVideos;

  FetchedPlaylistVideosState({required this.playlistVideos});
}
class NoPlaylistVideosState extends FetchPlaylistVideosState {}