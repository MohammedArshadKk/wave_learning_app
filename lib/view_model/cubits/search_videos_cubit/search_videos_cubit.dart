import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/video_model.dart';

part 'search_videos_state.dart';

class SearchVideosCubit extends Cubit<SearchVideosState> {
  SearchVideosCubit() : super(SearchVideosInitial());
  Timer? debounce;
  
  void debounceSearch(String searchText) {
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 300), () {
      searchVideo(searchText);
    });
  }

  Future<void> searchVideo(String searchText) async {
    if (searchText.isEmpty) {
      emit(SearchState(suggestions: const [], isLoading: false));
      return;
    }

    emit(SearchState(suggestions: const [], isLoading: true));

    try {
      CollectionReference videos =
          FirebaseFirestore.instance.collection('channelVideos');

      QuerySnapshot titleSnapshot = await videos
          .where('title', isGreaterThanOrEqualTo: searchText)
          .where('title', isLessThanOrEqualTo: '$searchText\uf8ff')
          .limit(10)
          .get();
      log(titleSnapshot.docs.length.toString());
      Set<String> uniqueSuggestions = {};

      for (var doc in titleSnapshot.docs) {
        uniqueSuggestions.add(doc['title'] as String);
      }

      List<String> suggestions = uniqueSuggestions.toList();
      emit(SearchState(suggestions: suggestions, isLoading: false));
    } catch (e) {
      log('Error searching videos: $e');
      emit(SearchState(suggestions: const [], isLoading: false));
    }
  }

  Future<void> pickSearchResultsVideos(String searchedText) async {
    emit(LoadingState());
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('channelVideos')
          .where('title', isGreaterThanOrEqualTo: searchedText)
          .where('title', isLessThanOrEqualTo: '$searchedText\uf8ff')
          .get();

      List<VideoModel> videosList = querySnapshot.docs.map((docs) {
        return VideoModel.fromMap(docs.data() as Map<String, dynamic>,
            documentid: docs.id);
      }).toList();

      log(videosList.length.toString());
      emit(VideoPickedState(listVideoModel: videosList));
    } catch (e) {
      log(e.toString());
    }
  }
}
