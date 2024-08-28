part of 'join_channel_cubit.dart';

@immutable
abstract class JoinChannelState {}

final class JoinChannelInitial extends JoinChannelState {}

class JoinedState extends JoinChannelState {}

class UnJoinedState extends JoinChannelState {}
