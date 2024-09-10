import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/screens/mobile/chat_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/chat_screen_widget/tile_widget.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';
 
class ChatGroupScreen extends StatefulWidget {
  const ChatGroupScreen({super.key});

  @override
  State<ChatGroupScreen> createState() => _ChatGroupScreenState();
}

class _ChatGroupScreenState extends State<ChatGroupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    context.read<GetJoinedChannelsCubit>().getJoinedChannels(_auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: CustomText(
          text: 'Message',
          color: AppColors.backgroundColor,
          fontSize: 26,
          fontFamily: Fonts.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          CustomContainer(
            height: 100,
            width: double.infinity,
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                labelText: 'Search',
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.normal,
                padding: 20,
                fontSize: 14,
                textColor: AppColors.secondaryColor,
                paddingForm: 30,
                borderRadius: 20,
                color: AppColors.backgroundColor,
                controller: searchController,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<GetJoinedChannelsCubit, GetJoinedChannelsState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const LoadingWidget();
                } else if (state is PickedJoinChannelsState) {
                  return ListView.builder(
                    itemCount: state.channelModelList.length,
                    itemBuilder: (ctx, index) {
                      final ChannelModel channel = state.channelModelList[index];
                      return BlocProvider(
                        create: (context) => ChatCubit()..fetchChatMessages(channel.documentId.toString()),
                        child: CustomChatTile(
                          channel: channel,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => BlocProvider.value(
                                value: context.read<ChatCubit>(),
                                child: ChatScreen(
                                  channelModel: channel,
                                  uid: _auth.currentUser!.uid,
                                ),
                              ),
                            ));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is NoChannelsState) {
                  return const NoDataWidget();
                } else {
                  return const NoDataWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}