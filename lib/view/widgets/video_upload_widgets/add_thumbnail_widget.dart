import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';

class AddThumbnailWidget extends StatelessWidget {
  const AddThumbnailWidget({super.key, });
 

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoUploadingBloc, VideoUploadingState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<VideoUploadingBloc>().add(PickThumbnailEvent());
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomContainer(
              height: 200,
              width: double.infinity,
              borderRadius: BorderRadius.circular(5),
              borderColor: Border.all(color: Colors.blueGrey),
              child: Builder(
                builder: (context) {
                  if (state is ThumbnailPikedState) {
            
                    return Image.file(
                      state.thumbnailPath,
                      fit: BoxFit.fill,
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            AppIcons.addThumbnail,
                            size: 40,
                          ),
                        ),
                        CustomText(
                          text: 'Add Thumbnail',
                          color: AppColors.secondaryColor,
                          fontSize: 20,
                          fontFamily: Fonts.labelText,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
