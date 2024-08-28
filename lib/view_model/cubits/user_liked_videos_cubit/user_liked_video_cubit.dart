import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'user_liked_video_state.dart';

class UserLikedVideoCubit extends Cubit<UserLikedVideoState> {
  UserLikedVideoCubit() : super(UserLikedVideoInitial());
  Future<void> fetchLikedvideos(String uid) async {
    try {
      emit(LoadingFetchUserLikedVideoState());
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final QuerySnapshot querySnapshot = await db
          .collection('channelVideos')
          .where('likes', arrayContains: uid)
          .get();
      if (querySnapshot.docs.isEmpty) {
        emit(NoLikedVideo());
      } else {
        List<VideoModel> videos = querySnapshot.docs.map((docs) {
          return VideoModel.fromMap(docs.data() as Map<String, dynamic>,
              documentid: docs.id);
        }).toList();
        emit(FetchedLikedVideoState(videoModel: videos));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }
}
