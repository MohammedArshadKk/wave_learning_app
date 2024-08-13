import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/services/repositories/channel%20services/channel_icon_add.dart';
import 'package:wave_learning_app/services/repositories/channel%20services/check_channel_created.dart';
part 'channel_creation_event.dart';
part 'channel_creation_state.dart';

class ChannelCreationBloc
    extends Bloc<ChannelCreationEvent, ChannelCreationState> {
  ChannelIconAdd channelIconAdd = ChannelIconAdd();
  ChannelCreationBloc() : super(ChannelCreationInitial()) {
    on<IconPickEvent>(iconPickevent);
    on<CreateButtonclickedEvent>(createButtonclickedEvent);
    on<ChannelEditEvent>(channelEditEvent);
  }

  Future<FutureOr<void>> iconPickevent(
      IconPickEvent event, Emitter<ChannelCreationState> emit) async {
    try {
      final icon = await channelIconAdd.pickIcon();
      if (icon != null) {
        final channelIcon = File(icon.path);
        log(channelIcon.path);
        emit(PickedIconState(channelIcon: channelIcon));
      }
    } catch (e) {
      emit(ChannelCreationErrorState());
    }
  }

  Future<FutureOr<void>> createButtonclickedEvent(
      CreateButtonclickedEvent event,
      Emitter<ChannelCreationState> emit) async {
    try {
      emit(ChannelCreationLoadingState());
      final channelcount =
          await checkChannelCreatedOrNot(event.channelModel.uid);
      if (channelcount == 0) {
        final iconUrl = await channelIconAdd.uploadIconTostorage(
            event.channelIcon, event.channelModel);
        if (iconUrl != null) {
          await channelIconAdd.addChannelInformationToDatabase(
              iconUrl, event.channelModel);
        }
        emit(ChannelCreatedstate());
      } else {
        emit(ChannelAlreadycreatedState());
      }
    } catch (e) {
      log(e.toString());
      emit(ChannelCreationErrorState());
    }
  }

  FutureOr<void> channelEditEvent(
      ChannelEditEvent event, Emitter<ChannelCreationState> emit) async {
    try {
      emit(EditScreenState());
      emit(ChannelCreationLoadingState());
      final iconUrl = await channelIconAdd.uploadIconTostorage(
          event.channelIcon, event.channelModel);
      if (iconUrl != null) {
        await channelIconAdd.editChannel(
            iconUrl, event.documentId, event.channelModel);
      }
      emit(EditedState());
    } catch (e) {
      log(e.toString());
    }
  }
}
