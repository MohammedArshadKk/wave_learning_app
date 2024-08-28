import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'get_channel_videos_state.dart';

class GetChannelVideosCubit extends Cubit<GetChannelVideosState> {
  GetChannelVideosCubit() : super(GetChannelVideosInitial());
  Future<void> getChannelVideos(String uid) async {
    emit(FetchingLoadingState());
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final QuerySnapshot querySnapshot = await db
          .collection('channelVideos')
          .where('uid', isEqualTo: uid)
          .get();
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
      emit(ErrorState());
    }
  }
}
