part of 'channel_created_or_not_bloc.dart';

@immutable
sealed class ChannelCreatedOrNotState {}

final class ChannelCreatedOrNotInitial extends ChannelCreatedOrNotState {}

class ChannelCreatedState extends ChannelCreatedOrNotState {}
class ChannelCreatedMeetingState extends ChannelCreatedOrNotState {}

class ChannelNotCreatedState extends ChannelCreatedOrNotState {}
