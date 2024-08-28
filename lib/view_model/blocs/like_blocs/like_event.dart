part of 'like_bloc.dart';

@immutable
abstract class LikeEvent {}

class LikeButtonclickedEvent extends LikeEvent {
  final String uid;
  final String documentid;

  LikeButtonclickedEvent({required this.uid, required this.documentid});
}

class CheckLikedEvent extends LikeEvent {
  final String uid;
  final String documentid;

  CheckLikedEvent({required this.uid, required this.documentid});
}
