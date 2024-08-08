import 'package:cloud_firestore/cloud_firestore.dart';

Future<QuerySnapshot> getUserDetails(userid)async{
 final FirebaseFirestore db=FirebaseFirestore.instance;
return await db.collection('users').where('uid',isEqualTo: userid).limit(1).get();
}