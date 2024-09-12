import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/watch_later_screen.dart';
import 'package:wave_learning_app/view/utils/app_strings.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/profile_widgets/profile_grid_view_item.dart';
import 'package:wave_learning_app/view_model/cubits/watch_later_cubit/watch_later_cubit.dart';

class GridWatchLaterWidget extends StatelessWidget {
  const GridWatchLaterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridViewItomWidget(
        text: AppStrings.watchLaterText,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => BlocProvider(
                    create: (context) => WatchLaterCubit(),
                    child: const WatchLaterScreen(),
                  )));
        },
        icon: AppIcons.watchLaterIcon);
  }
}
