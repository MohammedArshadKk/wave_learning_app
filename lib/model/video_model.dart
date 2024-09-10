class VideoModel {
  final String title;
  final String uid;
  final String channelName;
  final String description;
  final String email;
  String videoUrl;
  String thumbnailUrl;
  String time;
  final List<String>? tags;
  final List<String> likes;
  final String? documentid;
  final List<String> watchLater;
  final List<String> views;

  VideoModel({
    required this.title,
    required this.description,
    required this.uid,
    required this.channelName,
    required this.email,
    required this.likes,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.time,
    required this.watchLater,
    required this.views,
    this.tags,
    this.documentid,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'uid': uid,
      'channelName': channelName,
      'description': description,
      'email': email,
      'tags': tags,
      'likes': likes,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'time': time,
      'documentid': documentid,
      'watchLater': watchLater,
      'views': views,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map, {String? documentid}) {
    return VideoModel(
        title: map['title'] ?? '',
        uid: map['uid'] ?? '',
        channelName: map['channelName'] ?? '',
        description: map['description'] ?? '',
        email: map['email'] ?? '',
        tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
        likes: List<String>.from(map['likes'] ?? []),
        videoUrl: map['videoUrl'] ?? '',
        thumbnailUrl: map['thumbnailUrl'] ?? '',
        time: map['time'] ?? '',
        documentid: documentid,
        watchLater: List<String>.from(map['watchLater'] ?? []),
        views: List<String>.from(map['views'] ?? []));  
  }
}
