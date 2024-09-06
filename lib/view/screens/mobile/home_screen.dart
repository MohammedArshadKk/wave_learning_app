import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:wave_learning_app/view/screens/mobile/search_video_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/home_widgets/drawer_widget.dart';
import 'package:wave_learning_app/view/widgets/home_widgets/home_loading.dart';
import 'package:wave_learning_app/view/widgets/home_widgets/list_of_videos_widget.dart';
import 'package:wave_learning_app/view/widgets/home_widgets/top_sheet_widget.dart';
import 'package:wave_learning_app/view_model/cubits/get_all_videos%20cubit/get_all_videos_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/search_videos_cubit/search_videos_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<GetAllVideosCubit>().getAllVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 100,
        leading: Builder(builder: (context) {
          return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: AppIcons.menuIcon);
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => SearchVideosCubit(),
                                child: SearchVideoScreen(),
                              )));
                    },
                    child: AppIcons.searchIcon),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () async {
                      await showTopModalSheet<String?>(
                          context, TopSheetWidget());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        AppIcons.meetingIcon,
                        color: AppColors.backgroundColor,
                        size: 30,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
      drawer: const DrawerWidget(),
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
                return const NoDataWidget();
              } else {
                return const NoDataWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}
