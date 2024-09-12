import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/chat_message_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/chat_send_form_widget.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.channelModel, required this.uid, required this.name});

  final ChannelModel channelModel;
  final String uid;
  final String name;
  final TextEditingController massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final id = channelModel.documentId.toString();
    context.read<ChatCubit>().fetchChatMessages(id);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 100,
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        flexibleSpace: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage(channelModel.channelIconUrl.toString()),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: AppBarText(
                    text: channelModel.channelName,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ChatMessageWidget(
            uid: uid,
            id: id,
            name: name,
          ),
          SendFormWidget(massageController: massageController, uid: uid, id: id)
        ],
      ),
    );
  }
}
