import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'get_latest_joined_channel_videos_state.dart';

class GetLatestJoinedChannelVideosCubit
    extends Cubit<GetLatestJoinedChannelVideosState> {
  GetLatestJoinedChannelVideosCubit()
      : super(GetLatestJoinedChannelVideosInitial());

  Future<void> getLatestJoinedChannelVideos(String uid) async {
    try {
      emit(LoadingGetLatestVideosState());
      final FirebaseFirestore db = FirebaseFirestore.instance;
      List<VideoModel> videos = [];
      QuerySnapshot querySnapshot = await db
          .collection('channels')
          .where('members', arrayContains: uid)
          .get();
      List<String> joinedChannels = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['uid'] as String;
      }).toList();
      for (var channel in joinedChannels) {
        QuerySnapshot lastVideoSnapshot = await db
            .collection('channelVideos')
            .where('uid', isEqualTo: channel)
            .orderBy(FieldPath.documentId, descending: true)
            .limit(1)
            .get();
       if (lastVideoSnapshot.docs.isNotEmpty) {
          final videoData = lastVideoSnapshot.docs.first.data() as Map<String, dynamic>;
          VideoModel videoModel = VideoModel.fromMap(videoData);   
          videos.add(videoModel);
        } 
      }
     emit(PikedState(videos: videos));
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }
}
