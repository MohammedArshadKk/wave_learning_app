import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/services/repositories/channel%20services/check_channel_created.dart';

part 'channel_created_or_not_event.dart';
part 'channel_created_or_not_state.dart';

class ChannelCreatedOrNotBloc
    extends Bloc<ChannelCreatedOrNotEvent, ChannelCreatedOrNotState> {
  ChannelCreatedOrNotBloc() : super(ChannelCreatedOrNotInitial()) {
    on<ChekingChannelcreatedEvent>(chekingChannelcreatedEvent);
    on<ChekingChannelcreatedMeetingEvent>(chekingChannelcreatedMeetingEvent);
  }

  FutureOr<void> chekingChannelcreatedEvent(ChekingChannelcreatedEvent event,
      Emitter<ChannelCreatedOrNotState> emit) async {
    try {
      final channelcount = await checkChannelCreatedOrNot(event.uid);
      if (channelcount == 1) {
        log('created');
        emit(ChannelCreatedState());
      } else {
        log('not created');
        emit(ChannelNotCreatedState());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> chekingChannelcreatedMeetingEvent(
      ChekingChannelcreatedMeetingEvent event,
      Emitter<ChannelCreatedOrNotState> emit) async {
    try {
      final channelcount = await checkChannelCreatedOrNot(event.uid);
      if (channelcount == 1) {
        log('created');
        emit(ChannelCreatedMeetingState());
      } else {
        log('not created');
        emit(ChannelNotCreatedState());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
