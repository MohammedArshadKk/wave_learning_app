import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/view_model/functions/chat_functions/open_doc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> sendMessage(
      String channelDocumentId, String uid, String massage) async {
    try {
      final userQuerySnapshot = await db
          .collection('users')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();
      final userName = userQuerySnapshot.docs.isNotEmpty
          ? userQuerySnapshot.docs.first.data()['userName']
          : 'Unknown User';
      await db
          .collection('channels')
          .doc(channelDocumentId)
          .collection('message')
          .add({
        'uid': uid,
        'massageText': massage,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'text',
        'userName': userName,
      });
      log('message ayachu');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchChatMessages(String channelId) async {
    emit(ChatLoading());
    try {
      final chatMessages = db
          .collection('channels')
          .doc(channelId)
          .collection('message')
          .orderBy('timestamp')
          .snapshots();

      emit(ChatLoaded(chatMessages));
    } catch (e) {
      log('error');
    }
  }

  Future<void> sendDocument(
      File document, String documentId, String uid) async {
    try {
      emit(DocumentSening());
      final ref = storage.ref('docs/${DateTime.now()}');
      final docsnapshort = await ref.putFile(document);
      final docUrl = await docsnapshort.ref.getDownloadURL();
      log('docs store cythu');
      final userQuerySnapshot = await db
          .collection('users')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();
      final userName = userQuerySnapshot.docs.isNotEmpty
          ? userQuerySnapshot.docs.first.data()['userName']
          : 'Unknown User';
      await db
          .collection('channels')
          .doc(documentId)
          .collection('message')
          .add({
        'uid': uid,
        'doc': docUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'document',
        'userName': userName
      });

      log('doc ayachu');
      emit(DocumentSent());
    } catch (e) {
      log('error adichu $e');
    }
  }

  Future<void> docOpenCubit(String docUrl) async {
    emit(OpenDocLoading());
    await openDoc(docUrl);
    emit(DocOpened());
  }

  Future<void> deleteChat(
    String mainCollectionId,
    String subCollectionId,
  ) async {
    try {
      await db
          .collection('channels')
          .doc(mainCollectionId)
          .collection('message')
          .doc(subCollectionId)
          .delete();
    } catch (e) {
      log(e.toString());
    }
  }

  sendConferenceLink(String docId, String uid) async {
    try {
      final userQuerySnapshot = await db
          .collection('users')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();
      final userName = userQuerySnapshot.docs.isNotEmpty
          ? userQuerySnapshot.docs.first.data()['userName']
          : 'Unknown User';
          await db
          .collection('channels')
          .doc(docId)
          .collection('message')
          .add({
        'uid': uid,
        'massageText': '',
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'meeting', 
        'userName': userName,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
