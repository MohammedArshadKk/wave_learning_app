part of 'search_chat_groups_cubit.dart';

@immutable
sealed class SearchChatGroupsState {}

final class SearchChatGroupsInitial extends SearchChatGroupsState {}

class SearchChatGroup extends SearchChatGroupsState {
  final List<ChannelModel> listChannel;

  SearchChatGroup({required this.listChannel});
}
