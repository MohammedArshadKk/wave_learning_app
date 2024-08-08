part of 'fetchuserdata_bloc.dart';

@immutable
abstract class FetchuserdataState {}

final class FetchuserdataInitial extends FetchuserdataState {}

class UserDataFetchingstate extends FetchuserdataState {}

class UserDataFetchedstate extends FetchuserdataState {
  final UserModel userData;

  UserDataFetchedstate({required this.userData});
}

class UserDataFetchErrorstate extends FetchuserdataState {}
