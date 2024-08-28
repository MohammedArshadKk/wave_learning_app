import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/upload_model.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:workmanager/workmanager.dart';

part 'video_upload_background_state.dart';

class VideoUploadBackgroundCubit extends Cubit<VideoUploadBackgroundState> {
  VideoUploadBackgroundCubit() : super(VideoUploadBackgroundInitial());
  void startUpload(
      String videoPath, String thumbnailPath, VideoModel videoModel) {
    final id = (int.parse(DateTime.now().millisecondsSinceEpoch.toString()) %
            2147483647)
        .toString();
    Workmanager().registerOneOffTask("videoUploadTask_$id", 'videoUploadTask',
        inputData: {
          'id': id,
          'videoPath': videoPath,
          'thumbnailPath': thumbnailPath,
          'title': videoModel.title,
          'description': videoModel.description,
          'uid': videoModel.uid,
          'channelName': videoModel.channelName,
          'email': videoModel.email,
          'tags': videoModel.tags,
          'likes': videoModel.likes,
          'videoUrl': videoModel.videoUrl,
          'thumbnailUrl': videoModel.thumbnailUrl,
          'time': videoModel.time,
          'watchLater':videoModel.watchLater
        });
  }
}
