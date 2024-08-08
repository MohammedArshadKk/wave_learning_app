import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> checkChannelCreatedOrNot(uid) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final data =
      await db.collection('channels').where('uid', isEqualTo: uid).get();
  final document = data.docs;
  log(document.length .toString());
  return document.length;
}
