import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'watch_later_state.dart';

class WatchLaterCubit extends Cubit<WatchLaterState> {
  WatchLaterCubit() : super(WatchLaterInitial());
  final FirebaseFirestore db = FirebaseFirestore.instance;

  watchLaterButtonCliked(String uid, String documentid) async {
    final DocumentSnapshot documentSnapshot =
        await db.collection('channelVideos').doc(documentid).get();
    final List<dynamic> watchLater = documentSnapshot.get('watchLater');
    if (watchLater.contains(uid)) {
      await db.collection('channelVideos').doc(documentid).update({
        'watchLater': FieldValue.arrayRemove([uid])
      });
      emit(RemovedwatchLaterState());
    } else {
      await db.collection('channelVideos').doc(documentid).update({
        'watchLater': FieldValue.arrayUnion([uid])
      });
      emit(AddedwatchLaterState());
    }
  }

  checkSavedToWatchLater(String uid, String documentid) async {
    final DocumentSnapshot documentSnapshot =
        await db.collection('channelVideos').doc(documentid).get();
    final List<dynamic> watchLater = documentSnapshot.get('watchLater');
    if (watchLater.contains(uid)) {
      emit(AddedwatchLaterState());
    } else {
      emit(RemovedwatchLaterState());
    }
  }

  pickWatchLaterVideos(String uid) async {
    try {
      emit(WatchLaterLoadingState());
      final QuerySnapshot querySnapshot = await db
          .collection('channelVideos')
          .where('watchLater', arrayContains: uid)
          .get();
      if (querySnapshot.docs.isEmpty) {
        emit(NoVideosState());
      } else {
        List<VideoModel> videos = querySnapshot.docs.map((docs) {
          return VideoModel.fromMap(docs.data() as Map<String, dynamic>,
              documentid: docs.id);
        }).toList();
        emit(PickedWatchLaterVideos(videoModel: videos));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
