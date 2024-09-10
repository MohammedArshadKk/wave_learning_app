part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

final class HistoryInitial extends HistoryState {}

class HistoryVideosPikedState extends HistoryState {
  final List<VideoModel> historyVideos;

  HistoryVideosPikedState({required this.historyVideos});
}

class HistoryLoading extends HistoryState {}

class NoHistory extends HistoryState{}
