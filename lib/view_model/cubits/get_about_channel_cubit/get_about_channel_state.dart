part of 'get_about_channel_cubit.dart';

@immutable
abstract class GetAboutChannelState {}

final class GetAboutChannelInitial extends GetAboutChannelState {}

class LoadingState extends GetAboutChannelState {}

class FetchedState extends GetAboutChannelState {
  final ChannelModel channelModel;

  FetchedState({required this.channelModel});
}

class ErrorState extends GetAboutChannelState {}
