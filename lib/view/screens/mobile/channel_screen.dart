import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/screens/mobile/channel_side_playlist_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/channel_screen_widgets/about_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/channel_screen_widgets/videos_channel_screen.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_playlist_cubit/fetch_playlist_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/get_channel_videos_cubit/get_channel_videos_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/join_channel_cubit/join_channel_cubit.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key, required this.channelModel});
  final ChannelModel channelModel;
  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 100,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.backgroundColor,
          tabs: [
            CustomText(
                text: 'VIDEOS'.toLowerCase(),
                color: AppColors.backgroundColor,
                fontSize: 20,
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.w500),
            CustomText(
                text: 'PLAYLISTS'.toLowerCase(),
                color: AppColors.backgroundColor,
                fontSize: 20,
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.w500),
            CustomText(
                text: 'about',
                color: AppColors.backgroundColor,
                fontSize: 20,
                fontFamily: Fonts.primaryText,
                fontWeight: FontWeight.w500)
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => JoinChannelCubit(),
              ),
              BlocProvider(
                create: (context) => GetChannelVideosCubit(),
              ),
            ],
            child: VideosChannelScreenWidget(
              channelModel: widget.channelModel,
            ),
          ),
          BlocProvider(
            create: (context) => FetchPlaylistCubit(), 
            child: ChannelSidePlaylistScreen(channelUid: widget.channelModel.uid,),
          ),
          AboutWidget(
            channelModel: widget.channelModel,
          )
        ],
      ),
    );
  }
}
