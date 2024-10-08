import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:wave_learning_app/view/screens/mobile/video_conference_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/message_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/no_message_widget.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.uid, required this.id, required this.name});
  final String uid;
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is OpenDocLoading) {
          customLoading(context);
        } else if (state is DocOpened) {
          Navigator.pop(context);
          context.read<ChatCubit>().fetchChatMessages(id);
        }
      },
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return StreamBuilder<QuerySnapshot>(
              stream: state.chatMessages,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                if (messages.isEmpty) {
                  return const NoMessageWidget();
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData = messages[index];
                    final bool isSender = messageData['uid'] == uid;
                    final Timestamp? timestamp = messageData['timestamp'];
                    String time = '';
                    String date = '';
                    String userName = messageData['userName'];

                    String type = messageData['type'];
                    if (type == 'meeting') {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: width * 0.75,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: date,
                                  color: AppColors.lightTextColor,
                                  fontSize: 12,
                                  fontFamily: Fonts.primaryText,
                                  fontWeight: FontWeight.normal,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: isSender
                                          ? AppColors.primaryColor
                                              .withOpacity(0.8)
                                          : AppColors.lightTextColor
                                              .withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      height: 150,
                                      child: Stack(
                                        children: [
                                          Align(
                                              alignment: Alignment.topCenter,
                                              child: Icon(
                                                Icons.video_call_rounded,
                                                size: 80,
                                                color:
                                                    AppColors.backgroundColor,
                                              )),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        VideoConferenceScreen(
                                                      conferenceID: id,
                                                      uid: uid,
                                                      appSign: dotenv.env[
                                                          'zegocloud_app_sign']!,
                                                      appID: int.parse(dotenv
                                                              .env[
                                                          'zegocloud_app_id']!),
                                                      username: name,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CustomContainer(
                                                height: 50,
                                                width: width,
                                                color:
                                                    AppColors.backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Center(
                                                  child: CustomText(
                                                      text: "Join",
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 20,
                                                      fontFamily:
                                                          Fonts.primaryText,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    String message = type == 'document'
                        ? messageData['doc']
                        : messageData['massageText'];
                    if (timestamp != null) {
                      DateTime dateTime = timestamp.toDate();
                      time = DateFormat('hh:mm a').format(dateTime);
                      date = DateFormat('dd/MM/yyyy').format(dateTime);
                    }

                    return GestureDetector(
                      onLongPress: () {
                        if (isSender) {
                          PanaraInfoDialog.show(context,
                              message: 'Are you sure?',
                              buttonText: 'Delete', onTapDismiss: () {
                            context
                                .read<ChatCubit>()
                                .deleteChat(id, messageData.id);
                            Navigator.pop(context);
                          }, panaraDialogType: PanaraDialogType.warning);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: width * 0.75,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: date,
                                  color: AppColors.lightTextColor,
                                  fontSize: 12,
                                  fontFamily: Fonts.primaryText,
                                  fontWeight: FontWeight.normal,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: isSender
                                        ? AppColors.primaryColor
                                            .withOpacity(0.8)
                                        : AppColors.lightTextColor
                                            .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: MessageWidget(
                                      userName: userName,
                                      type: type,
                                      message: message,
                                      id: id,
                                      time: time),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
