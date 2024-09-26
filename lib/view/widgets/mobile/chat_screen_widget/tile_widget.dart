import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';

class CustomChatTile extends StatelessWidget {
  const CustomChatTile({
    super.key,
    required this.channel,
    required this.onTap,
  });
  final ChannelModel channel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: channel.channelIconUrl.toString(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                     const Icon(Icons.person),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: channel.channelName,
                    color: AppColors.secondaryColor,
                    fontSize: 20,
                    fontFamily: Fonts.primaryText,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 4),
                  BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoading) {
                        return const SizedBox.shrink();
                      }
                      if (state is ChatLoaded) {
                        return StreamBuilder(
                          stream: state.chatMessages,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return CustomText(
                                text: 'No messages yet',
                                color: AppColors.lightTextColor,
                                fontSize: 14,
                                fontFamily: Fonts.primaryText,
                                fontWeight: FontWeight.normal,
                              );
                            }

                            final lastMessage = snapshot.data!.docs.last.data()
                                as Map<String, dynamic>;
                            String text = 'Unknown message';

                            if (lastMessage['type'] == 'text') {
                              text =
                                  lastMessage['massageText'] ?? 'Empty message';
                              if (text.length > 30) {
                                text = '${text.substring(0, 30)}...';
                              }
                            } else if (lastMessage['type'] == 'document') {
                              text = 'document';
                            } else if (lastMessage['type'] == 'meeting') {
                              text = 'video conference link';
                            }

                            return CustomText(
                              text: text,
                              color: AppColors.lightTextColor,
                              fontSize: 14,
                              fontFamily: Fonts.primaryText,
                              fontWeight: FontWeight.normal,
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return StreamBuilder(
                    stream: state.chatMessages,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      final lastMessage = snapshot.data!.docs.last.data()
                          as Map<String, dynamic>;
                      final timestamp = lastMessage['timestamp'];

                      String timeText = '';
                      if (timestamp != null) {
                        try {
                          DateTime dateTime = timestamp.toDate();
                          timeText = DateFormat('hh:mm a').format(dateTime);
                        } catch (e) {
                          timeText = 'Invalid time';
                        }
                      } else {
                        timeText = 'No time';
                      }

                      return CustomText(
                        text: timeText,
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontFamily: Fonts.primaryText,
                        fontWeight: FontWeight.normal,
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
