import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/channel_model.dart';

part 'get_joined_channels_state.dart';

class GetJoinedChannelsCubit extends Cubit<GetJoinedChannelsState> {
  GetJoinedChannelsCubit() : super(GetJoinedChannelsInitial());
  Future<void> getJoinedChannels(String uid) async {
    emit(LoadingState());
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final QuerySnapshot querySnapshot = await db
          .collection('channels')
          .where('members', arrayContains: uid)
          .get();
      if (querySnapshot.docs.isEmpty) {
        emit(NoChannelsState());
      } else {
        List<ChannelModel> channelModel = querySnapshot.docs.map((docs) {
          return ChannelModel.formMap(docs.data() as Map<String, dynamic>,
              documentId: docs.id);
        }).toList();
        emit(PickedJoinChannelsState(channelModelList: channelModel));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }
}
