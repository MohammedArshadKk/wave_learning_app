part of 'search_videos_cubit.dart';

@immutable
abstract class SearchVideosState {}

class SearchVideosInitial extends SearchVideosState {}

class SearchState extends SearchVideosState {
  final List<String> suggestions;
  final bool isLoading;

  SearchState({required this.suggestions, required this.isLoading});
}

class LoadingState extends SearchVideosState {}

class VideoPickedState extends SearchVideosState {
  final List<VideoModel> listVideoModel;

  VideoPickedState({required this.listVideoModel});
} 
