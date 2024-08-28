import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/user_liked_screen.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/profile_widgets/profile_grid_view_item.dart';
import 'package:wave_learning_app/view_model/cubits/user_liked_videos_cubit/user_liked_video_cubit.dart';

class GridLikeWidget extends StatelessWidget {
  const GridLikeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.likedText,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => BlocProvider(
                    create: (context) => UserLikedVideoCubit(),
                    child: const UserLikedScreen(),
                  )));
        },
        icon: AppIcons.likedIcon);
  }
}
