part of 'web_selecte_group_cubit.dart';

@immutable
abstract class WebSelecteGroupState {}

final class WebSelecteGroupInitial extends WebSelecteGroupState {}

class GroupSelectedState extends WebSelecteGroupState {
  final ChannelModel selectedChannel;

  GroupSelectedState({required this.selectedChannel});
}
