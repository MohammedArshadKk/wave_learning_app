part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final Stream<QuerySnapshot> chatMessages;
  ChatLoaded(this.chatMessages,);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

class DocumentSent extends ChatState {}
class DocumentSening extends ChatState {}

class OpenDocLoading extends ChatState {}

class DocOpened extends ChatState {}
