import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/liked_widget/liked_videos_widget.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view_model/cubits/user_liked_videos_cubit/user_liked_video_cubit.dart';

class UserLikedScreen extends StatefulWidget {
  const UserLikedScreen({super.key});

  @override
  State<UserLikedScreen> createState() => _UserLikedScreenState();
}

class _UserLikedScreenState extends State<UserLikedScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    context
        .read<UserLikedVideoCubit>()
        .fetchLikedvideos(_auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 100,
        title: const AppBarText(text: 'Liked videos'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<UserLikedVideoCubit, UserLikedVideoState>(
        builder: (context, state) {
          if (state is LoadingFetchUserLikedVideoState) {
            return const LoadingWidget();
          } else if (state is FetchedLikedVideoState) {
            return  LikedVideosWidget(videoModel: state.videoModel,);
          } else if (state is NoLikedVideo) {
            return const NoDataWidget();
          }
          return const Center(
            child: Text('please check your network'),
          );
        },
      ),
    );
  }
}
