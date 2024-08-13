part of 'channel_creation_bloc.dart';

@immutable
abstract class ChannelCreationEvent {}

class IconPickEvent extends ChannelCreationEvent {}

class CreateButtonclickedEvent extends ChannelCreationEvent {
  final File? channelIcon;
  final ChannelModel channelModel;

  CreateButtonclickedEvent(
    this.channelModel, {
    required this.channelIcon,
  });
}

class ChannelEditEvent extends ChannelCreationEvent {
  final File? channelIcon;
  final ChannelModel channelModel;
  final String documentId;

  ChannelEditEvent(
    this.channelModel,
    this.documentId, {
    required this.channelIcon,
  });
}
