part of 'get_allchannels_cubit.dart';

@immutable
sealed class GetAllchannelsState {}

final class GetAllchannelsInitial extends GetAllchannelsState {}

class LoadingState extends GetAllchannelsState {}

class PickedAllChannelsState extends GetAllchannelsState {
 final List<ChannelModel> channelModelList;

  PickedAllChannelsState({required this.channelModelList});
}

class NoChannelsState extends GetAllchannelsState {}

class ErrorState extends GetAllchannelsState {}
