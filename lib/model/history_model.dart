import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String uid;
  final String videoId;
  final DateTime timestamp;

  HistoryModel(
      {required this.uid, required this.videoId, required this.timestamp});

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      uid: map['uid'] as String,
      videoId: map['videoId'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'videoId': videoId,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
