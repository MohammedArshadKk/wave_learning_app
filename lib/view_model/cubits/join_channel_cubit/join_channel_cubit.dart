import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'join_channel_state.dart';

class JoinChannelCubit extends Cubit<JoinChannelState> {
  JoinChannelCubit() : super(JoinChannelInitial());
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> joinChannel(String uid, String documentId) async {
    final DocumentSnapshot document =
        await db.collection('channels').doc(documentId).get();
    List<dynamic> members = document.get('members');
    if (members.contains(uid)) {
      await db.collection('channels').doc(documentId).update({
        'members': FieldValue.arrayRemove([uid])
      });
      emit(UnJoinedState());
    } else {
      await db.collection('channels').doc(documentId).update({
        'members': FieldValue.arrayUnion([uid])
      });
      emit(JoinedState());
    }
  }

  Future<void> checkjoinedOrNot(String uid, String documentId) async {
    final DocumentSnapshot document =
        await db.collection('channels').doc(documentId).get();
    List<dynamic> members = document.get('members');
    if (members.contains(uid)) {
      emit(JoinedState());
    } else {
      emit(UnJoinedState());
    }
  }
}
