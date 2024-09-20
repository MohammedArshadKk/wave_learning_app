import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/screens/mobile/chat_screen.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/tile_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';

class ChatGroupBeforeSearching extends StatelessWidget {
  ChatGroupBeforeSearching({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  create: (context) => ChatCubit()
                    ..fetchChatMessages(channel.documentId.toString()),
                  child: CustomChatTile(
                    channel: channel,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => BlocProvider.value(
                          value: context.read<ChatCubit>(),
                          child: ChatScreen(
                            channelModel: channel,
                            uid: _auth.currentUser!.uid,
                            name: _auth.currentUser!.displayName!,
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
    );
  }
}
