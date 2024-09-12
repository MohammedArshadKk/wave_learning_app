part of 'create_meeting_cubit.dart';

@immutable
abstract class CreateMeetingState {}

final class CreateMeetingInitial extends CreateMeetingState {}

class LoadingState extends CreateMeetingState {}

class PikedChannelidStete extends CreateMeetingState {
  final String id;

  PikedChannelidStete({required this.id});
}
