import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/all_channels_widgets/channels_list.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view_model/cubits/get_all_channels_cubit/get_allchannels_cubit.dart';

class AllChannelsScreen extends StatefulWidget {
  const AllChannelsScreen({super.key});

  @override
  State<AllChannelsScreen> createState() => _AllChannelsScreenState();
}

class _AllChannelsScreenState extends State<AllChannelsScreen> {
  @override
  void initState() {
    context.read<GetAllchannelsCubit>().getAllChannels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.backgroundColor),
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: 100,
          title: const AppBarText(text: 'Channels'),
          centerTitle: true,
          elevation: 5,
          actions: const [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: BlocBuilder<GetAllchannelsCubit, GetAllchannelsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const LoadingWidget();
            } else if (state is PickedAllChannelsState) {
              return ChannelsList(channelList: state.channelModelList);
            } else if (state is NoChannelsState) {
              return const NoDataWidget();
            }
            return const Center(
              child: Text('error'),
            );
          },
        ));
  }
}
