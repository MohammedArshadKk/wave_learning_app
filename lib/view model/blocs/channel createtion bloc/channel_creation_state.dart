part of 'channel_creation_bloc.dart';

@immutable
abstract class ChannelCreationState {}

final class ChannelCreationInitial extends ChannelCreationState {}

class PickedIconState extends ChannelCreationState {
  final File channelIcon;

  PickedIconState({required this.channelIcon});
}

class ChannelCreatedstate extends ChannelCreationState {}

class ChannelCreationLoadingState extends ChannelCreationState {}

class ChannelCreationErrorState extends ChannelCreationState {}

class ChannelAlreadycreatedState extends ChannelCreationState {}

class EditScreenState extends ChannelCreationState {}

class EditedState extends ChannelCreationState {}
