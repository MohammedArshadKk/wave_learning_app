import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/channel_model.dart';
part 'get_allchannels_state.dart';

class GetAllchannelsCubit extends Cubit<GetAllchannelsState> {
  GetAllchannelsCubit() : super(GetAllchannelsInitial());
  Future<void> getAllChannels() async {
    try {
      emit(LoadingState());
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final QuerySnapshot querySnapshot = await db.collection('channels').get();
      if (querySnapshot.docs.isEmpty) {
        emit(NoChannelsState());
      } else {
        final List<ChannelModel> channelList = querySnapshot.docs.map((docs) {
          return ChannelModel.formMap(docs.data() as Map<String, dynamic>,
              documentId: docs.id);
        }).toList();
        emit(PickedAllChannelsState(channelModelList: channelList));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }
}
