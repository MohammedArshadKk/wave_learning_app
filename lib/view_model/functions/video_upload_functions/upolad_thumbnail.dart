import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:wave_learning_app/model/video_model.dart';

Future<String?> thumbnailUploadTostrage(
    File? thubmbnail, VideoModel videomodel) async {
 final FirebaseStorage storage = FirebaseStorage.instance;

  String filename = DateTime.now().toString();
  final ref = storage.ref('thubmbnails/${videomodel.title}$filename');
  await ref.putFile(thubmbnail!);
  final iconUrl = await ref.getDownloadURL();
  return iconUrl;
}
