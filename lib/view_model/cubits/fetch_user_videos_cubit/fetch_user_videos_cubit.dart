import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_user_videos_state.dart';

class FetchUserVideosCubit extends Cubit<FetchUserVideosState> {
  FetchUserVideosCubit() : super(FetchUserVideosInitial());
}
