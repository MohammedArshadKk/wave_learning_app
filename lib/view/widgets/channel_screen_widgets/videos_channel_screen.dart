import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/screens/mobile/video_player_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/video_player_screen_widget/channel_detials_widget.dart';
import 'package:wave_learning_app/view_model/cubits/get_channel_videos_cubit/get_channel_videos_cubit.dart';
import 'package:wave_learning_app/view_model/functions/calculate_time_diff.dart';

class VideosChannelScreenWidget extends StatefulWidget {
  const VideosChannelScreenWidget({super.key, required this.channelModel});
  final ChannelModel channelModel;

  @override
  State<VideosChannelScreenWidget> createState() =>
      _VideosChannelScreenWidgetState();
}

class _VideosChannelScreenWidgetState extends State<VideosChannelScreenWidget> {
  @override
  void initState() {
    context
        .read<GetChannelVideosCubit>()
        .getChannelVideos(widget.channelModel.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var height = size.height;
    var width = size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 17, right: 10),
          child: ChannelDetialsWidget(
            channelName: widget.channelModel.channelName,
            iconUrl: widget.channelModel.channelIconUrl.toString(),
            totalVideos: widget.channelModel.members.length.toString(),
            documentId: widget.channelModel.documentId.toString(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 17, right: 10),
          child: Divider(),
        ),
        BlocBuilder<GetChannelVideosCubit, GetChannelVideosState>(
          builder: (context, state) {
            if (state is FetchingLoadingState) {
              return const Expanded(child: LoadingWidget());
            } else if (state is NoVideosState) {
              return const NoDataWidget();
            } else if (state is VideoFetchedState) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.videos.length,
                  itemBuilder: (context, index) {
                    VideoModel video = state.videos[index];
                    String title = video.title;
                    if (title.length > 16) {
                      title = "${title.substring(0, 16)}.....";
                    }
                    final difference = calculateTimeDiff(video.time);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => VideoPlayerScreen(
                                  videoModel: video,
                                  timeDiff: difference,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomContainer(
                          height: 120,
                          width: width,
                          color: AppColors.backgroundColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomContainer(
                                  height: 100,
                                  width: 180,
                                  color: AppColors.backgroundColor,
                                  borderColor: Border.all(
                                      color: AppColors.lightTextColor),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    video.thumbnailUrl,
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: title,
                                        color: AppColors.secondaryColor,
                                        fontSize: 18,
                                        fontFamily: Fonts.labelText,
                                        fontWeight: FontWeight.w500),
                                    CustomText(
                                        text: difference,
                                        color: AppColors.secondaryColor,
                                        fontSize: 17,
                                        fontFamily: Fonts.labelText,
                                        fontWeight: FontWeight.w500),
                                    Row(
                                      children: [
                                        const Icon(Icons.thumb_up_alt_outlined),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                            text:video.likes.length.toString(),
                                            color: AppColors.secondaryColor,
                                            fontSize: 17,
                                            fontFamily: Fonts.labelText,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text('error'),
              );
            }
          },
        ),
      ],
    );
  }
}
