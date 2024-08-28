import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/all_channels_widgets/channels_list.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';

class JoinedChannelScreen extends StatefulWidget {
  const JoinedChannelScreen({super.key});

  @override
  State<JoinedChannelScreen> createState() => _JoinedChannelScreenState();
}

class _JoinedChannelScreenState extends State<JoinedChannelScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    context
        .read<GetJoinedChannelsCubit>()
        .getJoinedChannels(_auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        title: const AppBarText(text: 'Added to channels'),
        toolbarHeight: 100,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<GetJoinedChannelsCubit, GetJoinedChannelsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return LoadingWidget();
          } else if (state is NoChannelsState) {
            return NoDataWidget();
          } else if (state is PickedJoinChannelsState) {
            return ChannelsList(channelList: state.channelModelList);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
