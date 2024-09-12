import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';

class VideoUploadImageWidget extends StatelessWidget {
  const VideoUploadImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return SizedBox(
      height: screenHeight * 0.35,
      width: screenWidth,
      child: InkWell(
        onTap: ()async {
         context.read<VideoUploadingBloc>().add(PickVideoEvent());

        },
        child: Image.asset(AppImages.uploadVideo),
      ),
    );
  }
}
