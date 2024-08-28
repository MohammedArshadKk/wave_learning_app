import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  LikeBloc() : super(LikeInitial()) {
    on<LikeButtonclickedEvent>(likeButtonclickedEvent);
    on<CheckLikedEvent>(checkLikedEvent);
  }
  FutureOr<void> likeButtonclickedEvent(
      LikeButtonclickedEvent event, Emitter<LikeState> emit) async {
    try {
      DocumentSnapshot docSnapshot =
          await db.collection('channelVideos').doc(event.documentid).get();
      List<dynamic> likes = docSnapshot.get('likes');
      if (likes.contains(event.uid)) {
        await db.collection('channelVideos').doc(event.documentid).update({
          'likes': FieldValue.arrayRemove([event.uid])
        });
        emit(DislikedState());
      } else {
        await db.collection('channelVideos').doc(event.documentid).update({
          'likes': FieldValue.arrayUnion([event.uid])
        });
        emit(LikedState());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> checkLikedEvent(
      CheckLikedEvent event, Emitter<LikeState> emit) async {
    DocumentSnapshot docSnapshot =
        await db.collection('channelVideos').doc(event.documentid).get();
    List<dynamic> likes = docSnapshot.get('likes');
    if (likes.contains(event.uid)) {
      emit(LikedState());
    } else {
      emit(DislikedState());
    }
  }
}
