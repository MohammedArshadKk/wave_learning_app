import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'search_videos_state.dart';

class SearchVideosCubit extends Cubit<SearchVideosState> {
  SearchVideosCubit() : super(SearchVideosInitial());
  Timer? debounce;
  void debounceSearch(String searchText) {
    if (debounce?.isActive ?? false) {
      debounce!.cancel();
    }
    debounce= Timer(const Duration(milliseconds: 300), (){
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

      QuerySnapshot tagSnapshot =
          await videos.where('tags', arrayContains: searchText).limit(10).get();

      Set<String> uniqueSuggestions = {};

      for (var doc in titleSnapshot.docs) {
        uniqueSuggestions.add(doc['title'] as String);
      }

      for (var doc in tagSnapshot.docs) {
        uniqueSuggestions.add(doc['title'] as String);
      }

      List<String> suggestions = uniqueSuggestions.toList();

      emit(SearchState(suggestions: suggestions, isLoading: false));
    } catch (e) {
      log(e.toString());
      emit(SearchState(suggestions: const [], isLoading: false));
    }
  }
  pickSearchResultsVideos(String searchedText){
   try {
     
   } catch (e) {
     
   }
  }
}
