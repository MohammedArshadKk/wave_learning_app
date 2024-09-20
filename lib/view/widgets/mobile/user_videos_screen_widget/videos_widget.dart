import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/screens/mobile/video_player_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_user_videos_cubit/fetch_user_videos_cubit.dart';
import 'package:wave_learning_app/view_model/functions/calculate_time_diff.dart';

class VideosWidget extends StatelessWidget {
  VideosWidget({super.key, required this.videos});
  final List<VideoModel> videos;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // var height = size.height;
    var width = size.width;
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        VideoModel video = videos[index];
        String title = video.title;
        if (title.length > 16) {
          title = "${title.substring(0, 16)}..";
        }
        final difference = calculateTimeDiff(video.time);

        return GestureDetector(
          onLongPress: () {
            if (_auth.currentUser!.uid == video.uid) {
              PanaraConfirmDialog.show(context,
                  message: 'Are you sure you want to delete this video?',
                  confirmButtonText: 'delete',
                  cancelButtonText: "cancel", onTapConfirm: () {
                context.read<FetchUserVideosCubit>().deleteVideo(
                    video.documentid.toString(), _auth.currentUser!.uid); 
                Navigator.pop(context);
              }, onTapCancel: () {
                Navigator.pop(context);
              }, panaraDialogType: PanaraDialogType.error);
            }
          },
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
                            fontFamily: Fonts.primaryText,
                            fontWeight: FontWeight.w500),
                        CustomText(
                            text: difference.toString(),
                            color: AppColors.secondaryColor,
                            fontSize: 17,
                            fontFamily: Fonts.primaryText,
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
                                fontFamily: Fonts.primaryText,
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
