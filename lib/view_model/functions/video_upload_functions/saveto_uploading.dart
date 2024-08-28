// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:wave_learning_app/model/video_model.dart';

// addVideoInformationToUploding(thumdbnailUrl, VideoModel videoModel) async {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   // final FirebaseAuth auth = FirebaseAuth.instance;
//   try {
//     final videoInformation = VideoModel(
//         title: videoModel.title,
//         description: videoModel.description,
//         uid: videoModel.uid,
//         channelName: '',
//         email: videoModel.email,
//         likes: [],
//         videoUrl: '',
//         thumbnailUrl: thumdbnailUrl,
//         time: DateTime.now().toString(),
//         tags: videoModel.tags,
//         watchLater: videoModel.watchLater);

//     await db.collection('channels').doc().set(videoInformation.toMap());
//     log('Image URL saved to Firestore');
//   } catch (e) {
//     log(e.toString());
//   }
// }
