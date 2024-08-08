import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/services/repositories/channel%20services/get_channel.dart';

part 'get_channel_details_event.dart';
part 'get_channel_details_state.dart';

class GetChannelDetailsBloc
    extends Bloc<GetChannelDetailsEvent, GetChannelDetailsState> {
  GetChannelDetailsBloc() : super(GetChannelDetailsInitial()) {
    on<FetchChanneldetailsEvent>(fetchChanneldetailsEvent);
  }

  FutureOr<void> fetchChanneldetailsEvent(FetchChanneldetailsEvent event,
      Emitter<GetChannelDetailsState> emit) async {
    try {
      emit(LoadingState());
      final data = await getChannel(event.uid);
      final documentId=data.docs[0].id;
      final document = data.docs[0].data() as Map<String, dynamic>;
      final channelData = ChannelModel.formMap(document);
      emit(ChannelFetchedState(documentId,channelModel: channelData));
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }
}
