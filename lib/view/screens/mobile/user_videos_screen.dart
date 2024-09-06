
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/playlist_widget.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/tab_bar_text.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/videos_widget.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_user_videos_cubit/fetch_user_videos_cubit.dart';

class UserVideosScreen extends StatefulWidget {
  const UserVideosScreen({super.key});

  @override
  State<UserVideosScreen> createState() => _UserVideosScreenState();
}

class _UserVideosScreenState extends State<UserVideosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _auth = FirebaseAuth.instance;

  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    context
        .read<FetchUserVideosCubit>()
        .fetchUserVideos(uid: _auth.currentUser!.uid);
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
        title: const AppBarText(text: 'Your Videos'),
        toolbarHeight: 100,
        bottom: TabBar(
          controller: _tabController,
          
          tabs: const [
            TabBarText(text: 'Videos'),
            TabBarText(text: 'Playlist')
          ],
          indicatorColor: AppColors.backgroundColor ,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocBuilder<FetchUserVideosCubit, FetchUserVideosState>(
            builder: (context, state) {
              if (state is VideoFetchingLoadingState) {
                return const LoadingWidget();
              } else if (state is VideoFetchedState) {
                return VideosWidget(videos: state.videos);
              }
              return const NoDataWidget(); 
            },
          ),
           BlocBuilder<FetchUserVideosCubit, FetchUserVideosState>(
            builder: (context, state) {
              if (state is VideoFetchingLoadingState) {
                return const LoadingWidget();
              } else if (state is VideoFetchedState) {
                return PlaylistWidget(userVideo: state.videos);
              }
              return const NoDataWidget();
            },
          ),
        ],
      ),
    );
  }
}
