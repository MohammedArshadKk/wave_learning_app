import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/services/repositories/channel%20services/get_channel.dart';
import 'package:wave_learning_app/view/screens/mobile/video_player_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/functions/calculate_time_diff.dart';

class ListOfVideosWidget extends StatefulWidget {
  const ListOfVideosWidget({super.key, required this.videos});
  final List<VideoModel> videos;

  @override
  State<ListOfVideosWidget> createState() => _ListOfVideosWidgetState();
}

class _ListOfVideosWidgetState extends State<ListOfVideosWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.videos.length,
        itemBuilder: (ctx, index) {
          final video = widget.videos[index];
          final difference = calculateTimeDiff(video.time);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => VideoPlayerScreen(
                      videoModel: video,
                      timeDiff: difference,
                      )));
            },
            child: CustomContainer(
              height: 300,
              width: double.infinity,
              color: AppColors.backgroundColor,
              child: Stack(
                children: [
                  CustomContainer(
                    height: 220,
                    width: double.infinity,
                    color: AppColors.secondaryColor,
                    child: CachedNetworkImage(imageUrl: video.thumbnailUrl),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Row(
                      children: [
                        FutureBuilder(
                            future: getChannel(video.uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else {
                                final channelData = snapshot.data!.docs[0]
                                    .data() as Map<String, dynamic>;
                                final channelIcon =
                                    channelData['channelIconUrl'];
                                return ClipOval(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.backgroundColor,
                                        border: Border.all()),
                                    child: CachedNetworkImage(
                                      imageUrl: channelIcon,
                                      placeholder: (context, url) =>
                                          const Icon(Icons.person),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.person),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: video.title,
                                color: AppColors.secondaryColor,
                                fontSize: 18,
                                fontFamily: Fonts.primaryText,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                text: difference,
                                color: AppColors.secondaryColor,
                                fontSize: 14,
                                fontFamily: Fonts.primaryText,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
