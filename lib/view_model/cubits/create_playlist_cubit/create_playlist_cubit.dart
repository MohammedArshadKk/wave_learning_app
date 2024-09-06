import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/playlist_model.dart';

part 'create_playlist_state.dart';

class CreatePlaylistCubit extends Cubit<CreatePlaylistState> {
  CreatePlaylistCubit() : super(CreatePlaylistInitial());
  final FirebaseFirestore db = FirebaseFirestore.instance;
  createPlaylist(PlaylistModel playlist) async {
    emit(LoadingState());
    try {
      await db.collection('playlists').doc().set(playlist.toMap());
      log('created');
      emit(CreatedState());
    } catch (e) {
      log(e.toString());
      emit(Errorstate());
    }
  }

  getPlaylists(String uid) async {
    emit(PickingLoadingState());
    try {
      final QuerySnapshot querySnapshot =
          await db.collection('playlists').where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isEmpty) {
        emit(Noplaylists());
      } else {
        List<PlaylistModel> playlists = querySnapshot.docs.map((docs) {
          return PlaylistModel.fromMap(docs.data() as Map<String, dynamic>,
              documentId: docs.id);
        }).toList();
        emit(PickedPlaylists(playlists: playlists));
      }
    } catch (e) {
      log(e.toString());
      emit(Errorstate());
    }
  }

  Future<void> addVideosToPlaylist(
      List<String> videos, String documentId) async {
    emit(AddingLoadingState());
    try {
      final DocumentSnapshot documentSnapshot =
          await db.collection('playlists').doc(documentId).get();
      List<String> existingVideos =
          List<String>.from(documentSnapshot.get('videos'));
      existingVideos.addAll(videos);
      await db.collection('playlists').doc(documentId).update({
        'videos': existingVideos,
      });

      log('Completed');
      emit(AddedState());
    } catch (e) {
      log(e.toString());
    }
  }

 
}
