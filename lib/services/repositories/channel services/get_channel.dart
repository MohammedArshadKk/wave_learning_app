import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> getChannel(userid) async {
   final FirebaseFirestore db=FirebaseFirestore.instance;
return await db.collection('channels').where('uid',isEqualTo: userid).limit(1).get();
}