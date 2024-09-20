import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/history_model.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> addViews(String uid, String documentid) async {
    try {
      await db.collection('channelVideos').doc(documentid).update({
        'views': FieldValue.arrayUnion([uid])
      });
      log("historyadded");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addToHistory(String uid, String videoId) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('history')
          .where('uid', isEqualTo: uid)
          .where('videoId', isEqualTo: videoId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isEmpty) {
        final historyModel =
            HistoryModel(uid: uid, videoId: videoId, timestamp: DateTime.now());
        await db.collection('history').doc().set(historyModel.toMap());
      } else if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;

        await db.collection('history').doc(docId).update({
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

Future<void> getHistoryvideos(String uid) async {
  emit(HistoryLoading());
  try {
    QuerySnapshot querySnapshot = await db
        .collection('history')
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)  
        .get();

    List<HistoryModel> historyList = querySnapshot.docs.map((docs) {
      return HistoryModel.fromMap(docs.data() as Map<String, dynamic>);
    }).toList();

    if (historyList.isEmpty) {
      emit(NoHistory());
    }

    List<VideoModel> historyVideos = [];
    for (HistoryModel historyModel in historyList) {
      final DocumentSnapshot document = await db
          .collection('channelVideos')
          .doc(historyModel.videoId)
          .get();
      historyVideos.add(VideoModel.fromMap(
          document.data() as Map<String, dynamic>,
          documentid: document.id));
    }
    
    emit(HistoryVideosPikedState(historyVideos: historyVideos));
  } catch (e) {
    log(' error  $e');
  }
}


}
