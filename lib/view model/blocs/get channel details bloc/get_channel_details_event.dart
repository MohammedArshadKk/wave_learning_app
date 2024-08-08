part of 'get_channel_details_bloc.dart';

@immutable
abstract class GetChannelDetailsEvent {}

class FetchChanneldetailsEvent extends GetChannelDetailsEvent {
  final String uid;
  FetchChanneldetailsEvent({required this.uid});
}
