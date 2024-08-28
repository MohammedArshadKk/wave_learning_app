import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'get_all_videos_state.dart';

class GetAllVideosCubit extends Cubit<GetAllVideosState> {
  GetAllVideosCubit() : super(GetAllVideosInitial());
  Future<void> getAllVideos() async {
    emit(AllVideoFetchingLoadingState());
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final QuerySnapshot querySnapshot =
          await db.collection('channelVideos').get();
      if (querySnapshot.docs.isEmpty) {
        emit(NoVideosState());
      } else {
        List<VideoModel> videos = querySnapshot.docs.map((docs) {
          return VideoModel.fromMap(docs.data() as Map<String, dynamic>,
              documentid: docs.id);
        }).toList();
        log(videos.length.toString());
        emit(AllVideoFetchedState(videos: videos));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }
}
