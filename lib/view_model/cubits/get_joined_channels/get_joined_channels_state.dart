part of 'get_joined_channels_cubit.dart';

@immutable
abstract class GetJoinedChannelsState {}

final class GetJoinedChannelsInitial extends GetJoinedChannelsState {}

class LoadingState extends GetJoinedChannelsState {}

class PickedJoinChannelsState extends GetJoinedChannelsState {
  final List<ChannelModel> channelModelList;

  PickedJoinChannelsState({required this.channelModelList});
}

class NoChannelsState extends GetJoinedChannelsState {}

class ErrorState extends GetJoinedChannelsState {}
