import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';
part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  GenerativeModel? _generativeModel;
  ChatSession? _chatSession;
  final String? apiKey;

  ChatBotCubit({required this.apiKey}) : super(ChatBotInitial());

  void initializeGenerativeModel() {
    if (_generativeModel == null) {
      _generativeModel = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey ?? '',
      );
      _chatSession = _generativeModel!.startChat();
    }
  }

  Future<void> sendMessage(String message) async {
    List<ChatMessage> previousMessages = [];
    if (state is ChatBotLoaded) {
      previousMessages = (state as ChatBotLoaded).messages;
    }

    final updatedMessages = List<ChatMessage>.from(previousMessages)
      ..add(ChatMessage(text: message, isFromUser: true));

    emit(ChatBotLoaded(messages: updatedMessages));

    try {
      final response = await _chatSession?.sendMessage(Content.text(message));
      final responseText = response?.text;

      if (responseText != null) {
        final updatedMessagesWithAIResponse =
            List<ChatMessage>.from(updatedMessages)
              ..add(ChatMessage(text: responseText, isFromUser: false));

        emit(ChatBotLoaded(messages: updatedMessagesWithAIResponse));
      } else {
        emit(ErrorChat('No response from AI'));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorChat(e.toString()));
    }
  }
}
