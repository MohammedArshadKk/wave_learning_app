import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> fetchUserVideoFirebase(userid) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  return await db
      .collection('channelVideos')
      .where('uid', isEqualTo: userid)
      .where('isUploaded', isEqualTo: true) 
      .get();
}

Future<QuerySnapshot> fetchUserUploadingVideo(userid) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  return await db
      .collection('channelVideos')
      .where('uid', isEqualTo: userid)
      .where('isUploaded', isEqualTo: false) 
      .get();
} 
