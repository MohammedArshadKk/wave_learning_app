import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_bot_widget/messages.dart';
import 'package:wave_learning_app/view_model/cubits/chat_bot/chat_bot_cubit.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBotCubit>().initializeGenerativeModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        toolbarHeight: 100,
        title: CustomText(
          text: 'Your AI',
          color: AppColors.primaryColor,
          fontSize: 30,
          fontFamily: Fonts.chatBotText,
          fontWeight: FontWeight.normal,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatBotCubit, ChatBotState>(
                listener: (context, state) {
                  if (state is ChatBotLoaded) {
                    _scrollDown();
                  }
                },
                builder: (context, state) {
                  if (state is ChatBotLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ChatBotMessagesWidget(
                          isFromuser: message.isFromUser,
                          text: message.text,
                        );
                      },
                    );
                  } else if (state is ErrorChat) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is ChatBotLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: 'Hello....',
                            color: AppColors.primaryColor,
                            fontSize: 40,
                            fontFamily: Fonts.primaryText,
                            fontWeight: FontWeight.w900),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'How can I help you today',
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  color: AppColors.primaryColor,
                                  fontFamily: Fonts.primaryText,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                          isRepeatingAnimation: false,
                          totalRepeatCount: 1,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promptController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      labelText: 'Message AI',
                    ),
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        final message = _promptController.text;
                        if (message.isNotEmpty) {
                          context.read<ChatBotCubit>().sendMessage(message);
                          _promptController.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
