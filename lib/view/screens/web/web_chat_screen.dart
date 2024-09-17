import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/tile_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/web/web_chat_screen_widget/web_message_screen_widges.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/web_selecte_group_cubit/web_selecte_group_cubit.dart';

class WebChatScreen extends StatefulWidget {
  const WebChatScreen({super.key});

  @override
  State<WebChatScreen> createState() => _WebChatScreenState();
}

class _WebChatScreenState extends State<WebChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context
        .read<GetJoinedChannelsCubit>()
        .getJoinedChannels(_auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    double containerWidth =
        screenWidth < 600 ? screenWidth * 0.45 : screenWidth * 0.35;
    double containerHeight = screenHeight * 0.8;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightTextColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: BlocBuilder<GetJoinedChannelsCubit, GetJoinedChannelsState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const LoadingWidget();
                } else if (state is PickedJoinChannelsState) {
                  return ListView.builder(
                    itemCount: state.channelModelList.length,
                    itemBuilder: (ctx, index) {
                      final ChannelModel channel =
                          state.channelModelList[index];
                      return BlocProvider(
                        create: (context) => ChatCubit()
                          ..fetchChatMessages(channel.documentId.toString()),
                        child: CustomChatTile(
                          channel: channel,
                          onTap: () {
                            context
                                .read<WebSelecteGroupCubit>()
                                .selectChannel(channel);
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
          const SizedBox(width: 20),
          WebMessageScreenWidges(
            uid: _auth.currentUser!.uid,
            name: _auth.currentUser!.displayName.toString(),
          ),
        ],
      ),
    );
  }
}
