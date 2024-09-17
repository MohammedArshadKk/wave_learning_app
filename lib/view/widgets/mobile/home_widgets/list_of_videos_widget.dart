import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/services/repositories/channel%20services/get_channel.dart';
import 'package:wave_learning_app/view/screens/mobile/video_player_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/functions/calculate_time_diff.dart';

class ListOfVideosWidget extends StatelessWidget {
  const ListOfVideosWidget({super.key, required this.videos});
  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          double childAspectRatio = 16 / 14;
          double maxContainerWidth = constraints.maxWidth;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 3;
            maxContainerWidth = constraints.maxWidth * 0.8; 
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 2;
          }
          return Center(
            child: SizedBox(
              width: maxContainerWidth,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: videos.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (ctx, index) {
                  final video = videos[index];
                  final difference = calculateTimeDiff(video.time);
                  String title = video.title.length > 35 
                      ? "${video.title.substring(0, 30)}....."
                      : video.title;

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => VideoPlayerScreen(
                          videoModel: video,
                          timeDiff: difference,
                        ),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl: video.thumbnailUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[200],
                                      child: const Center(child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: CustomText(
                                      text: difference,
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: Fonts.primaryText,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: CustomText(
                                      text: title,
                                      color: AppColors.secondaryColor,
                                      fontSize: 18,
                                      fontFamily: Fonts.primaryText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FutureBuilder(
                                          future: getChannel(video.uid),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const SizedBox(width: 32, height: 32);
                                            } else {
                                              final channelData = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                                              final channelIcon = channelData['channelIconUrl'];
                                              return ClipOval(
                                                child: Container(
                                                  height: 50,
                                                  width: 50, 
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.backgroundColor,
                                                    border: Border.all(color: Colors.grey[300]!), 
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: channelIcon,
                                                    placeholder: (context, url) => const SizedBox(),
                                                    errorWidget: (context, url, error) => const Icon(Icons.person),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: FutureBuilder(
                                            future: getChannel(video.uid),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return const SizedBox.shrink();
                                              } else {
                                                final channelData = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                                                final channelName = channelData['channelName'] ?? 'Unknown Channel';
                                                return CustomText(
                                                  text: channelName,
                                                  color: Colors.grey[600]!,
                                                  fontSize: 12,
                                                  fontFamily: Fonts.primaryText,
                                                  fontWeight: FontWeight.w400,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}