// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';

// Future<UploadTask> uploadVideo(File video) async {
//     FirebaseStorage storage = FirebaseStorage.instance;
//       File videoFile = File(video.path);
//       String fileName = DateTime.now().toString();
//       Reference ref = storage.ref().child('videos/$fileName');
//       UploadTask uploadTask = ref.putFile(videoFile);
//       return uploadTask;
// }