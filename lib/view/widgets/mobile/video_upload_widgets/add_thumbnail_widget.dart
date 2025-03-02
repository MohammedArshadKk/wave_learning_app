import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';

class AddThumbnailWidget extends StatelessWidget {
  const AddThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoUploadingBloc, VideoUploadingState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<VideoUploadingBloc>().add(PickThumbnailEvent());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.settingsColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Builder(
                  builder: (context) {
                    if (state is ThumbnailPikedState) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            state.thumbnailPath,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColors.secondaryColor.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Icon(
                              Icons.edit,
                              color: AppColors.backgroundColor,
                              size: 24,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        color: AppColors.settingsColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              AppIcons.addThumbnail,
                              size: 48,
                              color: AppColors.primaryColor.withOpacity(0.7),
                            ),
                            const SizedBox(height: 12),
                            CustomText(
                              text: 'Add Thumbnail',
                              color: AppColors.secondaryColor,
                              fontSize: 18,
                              fontFamily: Fonts.primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text: 'Recommended: 1280×720 or 1920×1080',
                              color: AppColors.lightTextColor,
                              fontSize: 14,
                              fontFamily: Fonts.primaryText,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}