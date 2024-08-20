import 'package:wave_learning_app/model/video_model.dart';

class UploadModel {
  final String id;
  final double progress;
  final VideoModel videoModel;

  UploadModel(
      {required this.id, required this.progress, required this.videoModel});
}
