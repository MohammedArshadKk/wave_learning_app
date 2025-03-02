import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/playlist_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/tab_bar_text.dart';
import 'package:wave_learning_app/view/widgets/mobile/user_videos_screen_widget/videos_widget.dart';
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
        title: const Center(child: AppBarText(text: 'Your Videos')),
        toolbarHeight: 100,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            TabBarText(text: 'Videos'),
            TabBarText(text: 'Playlist')
          ],
          indicatorColor: AppColors.backgroundColor,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('channelVideos')
                    .where('uid', isEqualTo: _auth.currentUser!.uid)
                    .where('isUploaded', isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('error');
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Container();
                  }
                  final List<VideoModel> upoladingVideos = snapshot.data!.docs
                      .map(
                        (data) => VideoModel.fromMap(data.data(),
                            documentid: data.id),
                      )
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                              text: 'Uploading...',
                              color: AppColors.secondaryColor,
                              fontSize: 20,
                              fontFamily: Fonts.primaryText,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: upoladingVideos.length,
                            itemBuilder: (context, index) {
                              final VideoModel video = upoladingVideos[index];
                              return Row(
                                children: [
                                  CustomContainer(
                                    height: 100,
                                    width: 180,
                                    color: AppColors.backgroundColor,
                                    borderColor: Border.all(
                                        color: AppColors.lightTextColor),
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      video.thumbnailUrl,
                                      fit: BoxFit.fitHeight,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              text: video.title,
                                              color: AppColors.secondaryColor,
                                              fontSize: 16,
                                              fontFamily: Fonts.primaryText,
                                              fontWeight: FontWeight.bold),
                                          SizedBox(
                                              child: LinearProgressIndicator(
                                            value: double.tryParse(
                                                video.progress.toString())!/100,
                                            color: AppColors.primaryColor,
                                          )),
                                          CustomText(
                                              text: '${video.progress}%',
                                              color: AppColors.secondaryColor,
                                              fontSize: 16,
                                              fontFamily: Fonts.primaryText,
                                              fontWeight: FontWeight.bold),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                      text: 'Uploaded.',
                      color: AppColors.secondaryColor,
                      fontSize: 20,
                      fontFamily: Fonts.primaryText,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: BlocBuilder<FetchUserVideosCubit, FetchUserVideosState>(
                  builder: (context, state) {
                    if (state is VideoFetchingLoadingState) {
                      return const LoadingWidget();
                    } else if (state is VideoFetchedState) {
                      return VideosWidget(videos: state.videos);
                    }
                    return const NoDataWidget();
                  },
                ),
              ),
            ],
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
