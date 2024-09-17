import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/services/repositories/user%20services/fetch_user_video_firebase.dart';
part 'fetch_user_videos_state.dart';

class FetchUserVideosCubit extends Cubit<FetchUserVideosState> {
  FetchUserVideosCubit() : super(FetchUserVideosInitial());

  Future<void> fetchUserVideos({required String uid}) async {
    try {
      emit(VideoFetchingLoadingState());
      final querySnapshot = await fetchUserVideoFirebase(uid);
      if (querySnapshot.docs.isEmpty) {
        emit(NoVideosState());
      } else {
        List<VideoModel> videos = querySnapshot.docs.map((docs) {
          return VideoModel.fromMap(docs.data() as Map<String, dynamic>,
              documentid: docs.id);
        }).toList();

        emit(VideoFetchedState(videos: videos));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> deleteVideo(String docId ,String uid) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('channelVideos').doc(docId).delete();
    log('Video with docId: $docId has been deleted');
   await fetchUserVideos(uid: uid);
   log('fetchUserVideos called after deletion');
  }
}
