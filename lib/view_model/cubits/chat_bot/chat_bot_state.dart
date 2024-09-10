part of 'chat_bot_cubit.dart';

@immutable
abstract class ChatBotState {}

final class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {}

class ChatBotLoaded extends ChatBotState {
  final List<ChatMessage> messages;

  ChatBotLoaded({required this.messages});
}

class ErrorChat extends ChatBotState {
final  String error;

  ErrorChat(this.error);
}

class ChatMessage {
  final String text;
  final bool isFromUser;

  ChatMessage({required this.text, required this.isFromUser});
}
 