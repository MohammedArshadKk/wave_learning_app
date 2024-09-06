
class PlaylistModel {
  final String playlistName;
  final String uid;
  final List<String> videos; 
  String? documentId;

  PlaylistModel({
    required this.playlistName,
    required this.uid,
    required this.videos,
    this.documentId,
  });

  factory PlaylistModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return PlaylistModel(
      playlistName: map['playlistName'] as String,
      uid: map['uid'] as String,
      videos: List<String>.from(map['videos'] as List<dynamic>),
      documentId: documentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playlistName': playlistName,
      'uid': uid,
      'videos': videos,
      'documentId': documentId,
    };
  }
}
