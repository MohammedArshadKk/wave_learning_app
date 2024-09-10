import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/videos_widget.dart';
import 'package:wave_learning_app/view_model/cubits/history_cubit/history_cubit.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    context.read<HistoryCubit>().getHistoryvideos(_auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
       backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const AppBarText(text: 'History'),
        toolbarHeight: 100,
        backgroundColor: AppColors.primaryColor,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const LoadingWidget();
          } else if (state is HistoryVideosPikedState) {
            return VideosWidget(videos: state.historyVideos);
          } else if (state is NoHistory) {
            return const NoDataWidget(
              text: 'No history available',
            );
          }
          return Container();
        },
      ),
    );
  }
}
