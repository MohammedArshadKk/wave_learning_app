import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/screens/mobile/chat_screen.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_screen_widget/tile_widget.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';

class AfterSearch extends StatelessWidget {
  AfterSearch({super.key, required this.channelModelList});
  final List<ChannelModel> channelModelList;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded( 
      child: ListView.builder(
        itemCount: channelModelList.length,
        itemBuilder: (ctx, index) {
          final ChannelModel channel = channelModelList[index];
          return BlocProvider(
            create: (context) =>
                ChatCubit()..fetchChatMessages(channel.documentId.toString()),
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
      ),
    );
  }
}
