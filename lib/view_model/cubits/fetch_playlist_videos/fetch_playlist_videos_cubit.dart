import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'fetch_playlist_videos_state.dart';

class FetchPlaylistVideosCubit extends Cubit<FetchPlaylistVideosState> {
  FetchPlaylistVideosCubit() : super(FetchPlaylistVideosInitial());
  final FirebaseFirestore db=FirebaseFirestore.instance;
   Future<void> fetchPlaylistVideos(List<String> documentIds) async {
    emit(FetchPlaylistVideosLoadingState());
    try {
      List<VideoModel> playlistVideos = [];
      for (var id in documentIds) {
        final DocumentSnapshot documentSnapshot =
            await db.collection('channelVideos').doc(id).get();
        if (documentSnapshot.exists) {
          playlistVideos.add(VideoModel.fromMap(
              documentSnapshot.data() as Map<String, dynamic>,
              documentid: documentSnapshot.id));
        }
      }
      if (playlistVideos.isEmpty) {
        emit(NoPlaylistVideosState());
      }
      log(playlistVideos.length.toString());
      emit(FetchedPlaylistVideosState(playlistVideos: playlistVideos));
    } catch (e) {
      log(e.toString());
    }
  }
}
