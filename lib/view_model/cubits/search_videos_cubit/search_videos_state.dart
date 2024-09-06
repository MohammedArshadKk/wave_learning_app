part of 'search_videos_cubit.dart';

@immutable
abstract class SearchVideosState {}

final class SearchVideosInitial extends SearchVideosState {}

class SearchState extends SearchVideosState {
  final List<String> suggestions;
  final bool isLoading;
   
  SearchState({required this.suggestions, required this.isLoading});
}
