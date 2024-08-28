import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/channel_model.dart';

part 'get_about_channel_state.dart';

class GetAboutChannelCubit extends Cubit<GetAboutChannelState> {
  GetAboutChannelCubit() : super(GetAboutChannelInitial());
  Future<void> getAboutChannel(String uid) async {
    emit(LoadingState());
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final QuerySnapshot querySnapshot =
          await db.collection('channels').where('uid').limit(1).get();
      final document=querySnapshot.docs[0].data() as Map<String , dynamic>; 
      final ChannelModel channelModel=ChannelModel.formMap(document);
      emit(FetchedState(channelModel: channelModel));
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }
}
