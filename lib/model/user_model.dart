class UserModel {
  final String? uid;
  final String userName;
  final String email;


  UserModel({
    required this.userName,
    required this.email,
     this.uid,

  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
    };
  }

  factory UserModel.formMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
    );
  }
}
