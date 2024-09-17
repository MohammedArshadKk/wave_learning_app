import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/chat_message_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/chat_send_form_widget.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/web_selecte_group_cubit/web_selecte_group_cubit.dart';

class WebMessageScreenWidges extends StatelessWidget {
  WebMessageScreenWidges({
    super.key,
    required this.uid,
    required this.name,
  });
  final String uid;
  final String name;
  final TextEditingController massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.45 : screenWidth * 0.35;
    double containerHeight = screenHeight * 0.8;
    double fontSize = screenWidth < 600 ? 12 : 14;
    String id;
    return BlocBuilder<WebSelecteGroupCubit, WebSelecteGroupState>(
      builder: (context, state) {
        if (state is GroupSelectedState) {
          id = state.selectedChannel.documentId.toString();
          context.read<ChatCubit>().fetchChatMessages(id);

          return Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightTextColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CustomContainer(
                    height: screenHeight * 0.15,
                    width: containerWidth,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              state.selectedChannel.channelIconUrl.toString()),
                        ),
                        title: CustomText(
                            text: state.selectedChannel.channelName,
                            color: AppColors.backgroundColor,
                            fontSize: fontSize,
                            fontFamily: Fonts.primaryText,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoaded) {
                        return ChatMessageWidget(uid: uid, id: id, name: name);
                      }
                      return Container();
                    },
                  )),
                  SendFormWidget(
                      massageController: massageController, uid: uid, id: id)
                ],
              ));
        } else {
          return Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightTextColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Select a chat to start messaging',
                style: TextStyle(
                  color: AppColors.lightTextColor,
                  fontSize: fontSize,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
