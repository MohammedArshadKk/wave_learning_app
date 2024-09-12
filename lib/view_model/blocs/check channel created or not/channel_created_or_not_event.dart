part of 'channel_created_or_not_bloc.dart';

@immutable
abstract class ChannelCreatedOrNotEvent {}

class ChekingChannelcreatedEvent extends ChannelCreatedOrNotEvent {
  final String uid;

  ChekingChannelcreatedEvent({required this.uid});
}
class ChekingChannelcreatedMeetingEvent extends ChannelCreatedOrNotEvent {
  final String uid;

  ChekingChannelcreatedMeetingEvent({required this.uid});

}

