import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/watch_later_widgets/watch_later_videos_widget.dart';
import 'package:wave_learning_app/view_model/cubits/watch_later_cubit/watch_later_cubit.dart';

class WatchLaterScreen extends StatefulWidget {
  const WatchLaterScreen({super.key});

  @override
  State<WatchLaterScreen> createState() => _WatchLaterScreenState();
}

class _WatchLaterScreenState extends State<WatchLaterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    context
        .read<WatchLaterCubit>()
        .pickWatchLaterVideos(_auth.currentUser!.uid);

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
        title: const Center(child: AppBarText(text: 'Watch Later')),
      ),
      body: BlocBuilder<WatchLaterCubit, WatchLaterState>(
        builder: (context, state) {
          if (state is WatchLaterLoadingState) {
            return const LoadingWidget();
          } else if (state is PickedWatchLaterVideos) {
            return WatchLaterVideosWidget(videos: state.videoModel);
          } else if (state is NoVideosState) {
            return const SingleChildScrollView(
                child: Center(child: NoDataWidget()));
          } else {
            return Center(
              child: CustomText(
                  text: 'error',
                  color: AppColors.secondaryColor,
                  fontSize: 25,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.bold),
            );
          }
        },
      ),
    );
  }
}
