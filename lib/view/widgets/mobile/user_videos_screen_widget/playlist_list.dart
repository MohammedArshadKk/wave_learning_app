import 'package:flutter/material.dart';
import 'package:wave_learning_app/model/playlist_model.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class PlaylistList extends StatelessWidget {
  const PlaylistList({super.key, required this.playlists, required this.onTap, this.userVideo, });
  final List<PlaylistModel> playlists;
  final List<VideoModel>? userVideo;
  final Function(PlaylistModel playlist) onTap;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: playlists.length,
      itemBuilder: (ctx, index) {
        final playlist = playlists[index];
        return GestureDetector(
          onTap: () => onTap(playlist),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CustomContainer(
                          width: 90,
                          height: 90,
                          borderRadius: BorderRadius.circular(10),
                          borderColor: Border.all(color: Colors.grey),
                          color: Colors.grey[200],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: CustomContainer(
                          width: 90,
                          height: 90,
                          borderRadius: BorderRadius.circular(10),
                          borderColor: Border.all(color: Colors.grey),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: playlist.videos.isEmpty
                                ? Image.asset(
                                    AppImages.noDataImage,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AppImages.noDataImage,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                            Icons.error,
                                            color: Colors.red[300],
                                            size: 50),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        playlist.playlistName,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 20,
                          fontFamily: Fonts.primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${playlist.videos.length} ${playlist.videos.length == 1 ? 'video' : 'videos'}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontFamily: Fonts.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[600],
                  size: 30,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
