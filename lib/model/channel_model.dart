class ChannelModel {
  final String channelName;
  final String email;
  final String uid;
  final String? channelIconUrl;
  final String description;
  final String focusedSubject;
  final List<String> members;
  final String? documentId;

  ChannelModel(
      {required this.channelName,
      required this.email,
      required this.uid,
      required this.description,
      required this.focusedSubject,
      required this.members,
      this.channelIconUrl,
      this.documentId
      });
  factory ChannelModel.formMap(Map<String, dynamic> map,{String? documentId}) {
    return ChannelModel(
      channelName: map['channelName'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      description: map['description'] ?? '',
      focusedSubject: map['focusedSubject'] ?? '',
      channelIconUrl: map['channelIconUrl'] ?? '',
      members: List<String>.from(map['members'] ?? []),
      documentId: documentId,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "channelName": channelName,
      "email": email,
      "uid": uid,
      "channelIconUrl": channelIconUrl,
      "description": description,
      "focusedSubject": focusedSubject,
      "members": members,
      "documentId":documentId
    };
  }
}
