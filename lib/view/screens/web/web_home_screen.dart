import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/home_loading.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/list_of_videos_widget.dart';
import 'package:wave_learning_app/view_model/cubits/get_all_videos%20cubit/get_all_videos_cubit.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  @override
  void initState() {
    context.read<GetAllVideosCubit>().getAllVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          BlocBuilder<GetAllVideosCubit, GetAllVideosState>(
            builder: (context, state) {
              if (state is AllVideoFetchingLoadingState) {
                return const Expanded(child: HomeLoading());
              } else if (state is AllVideoFetchedState) {
                return ListOfVideosWidget(
                  videos: state.videos,
                );
              } else if (state is NoVideosState) {
                return const SingleChildScrollView(child: NoDataWidget());
              } else {
                return const SingleChildScrollView(child: NoDataWidget());
              }
            },
          ),
        ],
      ),
    );
  }
}
