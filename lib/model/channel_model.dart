class ChannelModel {
  final String channelName;
  final String email;
  final String uid;
  final String? channelIconUrl;
  final String description;
  final String focusedSubject;

  ChannelModel(
      {required this.channelName,
      required this.email,
      required this.uid,
      required this.description,
      required this.focusedSubject,
      this.channelIconUrl});
  factory ChannelModel.formMap(Map<String, dynamic> map) {
    return ChannelModel(
      channelName: map['channelName'],
      email: map['email'],
      uid: map['uid'],
      description: map['description'],
      focusedSubject: map['focusedSubject'],
      channelIconUrl: map['channelIconUrl'],
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
    };
  }
}
