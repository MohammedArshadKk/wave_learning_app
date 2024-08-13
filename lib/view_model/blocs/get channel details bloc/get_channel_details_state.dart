part of 'get_channel_details_bloc.dart';

@immutable
sealed class GetChannelDetailsState {}

final class GetChannelDetailsInitial extends GetChannelDetailsState {}

class LoadingState extends GetChannelDetailsState {}
class ChannelFetchedState extends GetChannelDetailsState {
 final ChannelModel channelModel;
final String documentId; 
  ChannelFetchedState(this.documentId, {required this.channelModel});
}
class ErrorState extends GetChannelDetailsState {}
