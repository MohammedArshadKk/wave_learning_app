import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key,
      required this.userName,
      required this.type,
      required this.id,
      required this.time,
      required this.message});
  final String userName;
  final String type;
  final String message;
  final String id;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: userName,
          color: Colors.white70,
          fontSize: 12,
          fontFamily: Fonts.primaryText,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 5),
        if (type == 'text')
          CustomText(
            text: message,
            color: Colors.white,
            fontSize: 16,
            fontFamily: Fonts.primaryText,
            fontWeight: FontWeight.normal,
          ),
        if (type != 'text')
          GestureDetector(
            onTap: () async {
              context.read<ChatCubit>().docOpenCubit(message);
              context.read<ChatCubit>().fetchChatMessages(id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Open document',
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 5),
                Icon(
                  Icons.insert_drive_file,
                  color: AppColors.backgroundColor,
                ),
              ],
            ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: CustomText(
            text: time,
            color: Colors.white,
            fontSize: 10,
            fontFamily: Fonts.primaryText,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
