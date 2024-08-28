import 'package:flutter/material.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/screens/mobile/video_player_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/functions/calculate_time_diff.dart';

class LikedVideosWidget extends StatelessWidget {
  const LikedVideosWidget({super.key, required this.videoModel});
  final List<VideoModel> videoModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var height = size.height;
    var width = size.width;
    return ListView.builder(
      itemCount: videoModel.length,
      itemBuilder: (context, index) {
        VideoModel video = videoModel[index];
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
                      borderColor: Border.all(color: AppColors.lightTextColor),
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
                                text: video.likes.length.toString(),
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
    );
  }
}
