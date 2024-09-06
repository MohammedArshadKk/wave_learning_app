part of 'create_playlist_cubit.dart';

@immutable
abstract class CreatePlaylistState {}

final class CreatePlaylistInitial extends CreatePlaylistState {}

class CreatedState extends CreatePlaylistState {}

class LoadingState extends CreatePlaylistState {}

class PickingLoadingState extends CreatePlaylistState {}

class Errorstate extends CreatePlaylistState {}

class Noplaylists extends CreatePlaylistState {}

class PickedPlaylists extends CreatePlaylistState {
  final List<PlaylistModel> playlists;

  PickedPlaylists({required this.playlists});
}

class AddingLoadingState extends CreatePlaylistState {}


class AddedState extends CreatePlaylistState {}

