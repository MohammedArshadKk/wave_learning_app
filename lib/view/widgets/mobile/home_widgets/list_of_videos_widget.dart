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
  const ListOfVideosWidget({Key? key, required this.videos}) : super(key: key);
  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (ctx, index) {
          final video = videos[index];
          final difference = calculateTimeDiff(video.time);
          String title = video.title.length > 35 
              ? "${video.title.substring(0, 30)}....."
              : video.title;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: GestureDetector(
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
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
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
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            future: getChannel(video.uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const SizedBox(width: 40, height: 40);
                              } else {
                                final channelData = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                                final channelIcon = channelData['channelIconUrl'];
                                return ClipOval(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.backgroundColor,
                                      border: Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: channelIcon,
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.person),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: title,
                                  color: AppColors.secondaryColor,
                                  fontSize: 16,
                                  fontFamily: Fonts.primaryText,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(height: 4),
                                FutureBuilder(
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
                                        fontSize: 14,
                                        fontFamily: Fonts.primaryText,
                                        fontWeight: FontWeight.w400,
                                      );
                                    }
                                  },
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
            ),
          );
        },
      ),
    );
  }
} 