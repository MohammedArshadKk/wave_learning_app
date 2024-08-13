import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_uploading_event.dart';
part 'video_uploading_state.dart';

class VideoUploadingBloc extends Bloc<VideoUploadingEvent, VideoUploadingState> {
  VideoUploadingBloc() : super(VideoUploadingInitial()) {
    on<VideoUploadingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
