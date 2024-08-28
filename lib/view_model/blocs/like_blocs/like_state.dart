part of 'like_bloc.dart';

@immutable
abstract class LikeState {}

final class LikeInitial extends LikeState {}

class LikedState extends LikeState {}

class DislikedState extends LikeState {}
