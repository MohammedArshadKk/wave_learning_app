import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/playlist_model.dart';

part 'fetch_playlist_state.dart';

class FetchPlaylistCubit extends Cubit<FetchPlaylistState> {
  FetchPlaylistCubit() : super(FetchPlaylistInitial());

  final FirebaseFirestore db = FirebaseFirestore.instance;
   getChannelsidePlaylists(String uid) async {
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


}
