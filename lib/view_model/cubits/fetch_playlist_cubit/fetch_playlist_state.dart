part of 'fetch_playlist_cubit.dart';

@immutable
abstract class FetchPlaylistState {}

final class FetchPlaylistInitial extends FetchPlaylistState {}

class PickingLoadingState extends FetchPlaylistState {}
class Noplaylists extends FetchPlaylistState {}
class Errorstate extends FetchPlaylistState {}
class PickedPlaylists extends FetchPlaylistState {
 final List<PlaylistModel> playlists;

  PickedPlaylists({required this.playlists});
}
