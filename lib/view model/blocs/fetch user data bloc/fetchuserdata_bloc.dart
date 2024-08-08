import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/user_model.dart';
import 'package:wave_learning_app/services/repositories/user%20services/fetch_user_data_firebase.dart';

part 'fetchuserdata_event.dart';
part 'fetchuserdata_state.dart';

class FetchuserdataBloc extends Bloc<FetchuserdataEvent, FetchuserdataState> {
  FetchuserdataBloc() : super(FetchuserdataInitial()) {
    on<UserDataFetchingEvent>(userDataFetchingEvent);
  }

  FutureOr<void> userDataFetchingEvent(
      UserDataFetchingEvent event, Emitter<FetchuserdataState> emit) async {
    try {
      final user = await getUserDetails(event.uid);
      final document = user.docs[0].data() as Map<String, dynamic>;
      final userdata = UserModel.formMap(document);
      log(userdata.toString());
      emit(UserDataFetchedstate(userData: userdata));
    } catch (e) {
      log('error $e');
      emit(UserDataFetchErrorstate()); 
    }
  }  
}
