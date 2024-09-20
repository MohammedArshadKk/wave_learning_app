import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/channel_model.dart';

part 'search_chat_groups_state.dart';

class SearchChatGroupsCubit extends Cubit<SearchChatGroupsState> {
  SearchChatGroupsCubit() : super(SearchChatGroupsInitial());
  Timer? debounce;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> debounceSearchChannel(String searchText, String uid) async {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(
      const Duration(
        milliseconds: 500,
      ),
      () {
        searchGroup(searchText, uid);
      },
    );
  }

  Future<void> searchGroup(String searchText, String uid) async {
    try {
      if (searchText.isEmpty) {
        emit(SearchChatGroupsInitial());
        return;
      }
      QuerySnapshot querySnapshot = await db
          .collection('channels')
          .where(
            'members',
            arrayContains: uid,
          )
          .where('channelName', isGreaterThanOrEqualTo: searchText)
          .where('channelName', isLessThanOrEqualTo: '$searchText\uf8ff')
          .get();
      List<ChannelModel> listChannel = querySnapshot.docs.map((docs) {
        return ChannelModel.formMap(docs.data() as Map<String, dynamic>,
            documentId: docs.id);
      }).toList();
      
      emit(SearchChatGroup(listChannel: listChannel));
    } catch (e) {
      log(e.toString());
    }
  }
}
