part of 'fetchuserdata_bloc.dart';

@immutable
abstract class FetchuserdataEvent {}

class UserDataFetchingEvent extends FetchuserdataEvent {
  final String uid;

  UserDataFetchingEvent({required this.uid});
}
