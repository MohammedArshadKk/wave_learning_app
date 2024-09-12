import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'create_meeting_state.dart';

class CreateMeetingCubit extends Cubit<CreateMeetingState> {
  CreateMeetingCubit() : super(CreateMeetingInitial());
  Future<void> pikeChannelid(String uid) async {
    emit(LoadingState());
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('channels')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();
      final channelId = querySnapshot.docs.first.id;
      log(channelId);
      emit(PikedChannelidStete(id: channelId));
    } catch (e) {
      log(e.toString());
    }
  }
}
