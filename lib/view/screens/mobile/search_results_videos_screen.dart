import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/videos_widget.dart';
import 'package:wave_learning_app/view_model/cubits/search_videos_cubit/search_videos_cubit.dart';

class SearchResultsVideosScreen extends StatefulWidget {
  const SearchResultsVideosScreen({super.key, required this.text});
  final String text;

  @override
  State<SearchResultsVideosScreen> createState() =>
      _SearchResultsVideosScreenState();
}

class _SearchResultsVideosScreenState extends State<SearchResultsVideosScreen> {
  @override
  void initState() {
    context.read<SearchVideosCubit>().pickSearchResultsVideos(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        toolbarHeight: 100,
      ),
      body: BlocBuilder<SearchVideosCubit, SearchVideosState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const LoadingWidget();
          } else if (state is VideoPickedState) {
            return VideosWidget(videos: state.listVideoModel);
          }
          return Container();
        },
      ),
    );
  }
}
