import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> fetchUserVideoFirebase(userid) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  return await db
      .collection('channelVideos')
      .where('uid', isEqualTo: userid)
      .get();
}
