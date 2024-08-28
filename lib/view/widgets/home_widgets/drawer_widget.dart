import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/all_channels_screen.dart';
import 'package:wave_learning_app/view/screens/mobile/joined_channel_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_drawer_itom_widget.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/get_all_channels_cubit/get_allchannels_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 130),
      child: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CustomDrawerItomWidget(text: 'Home', icon: AppIcons.homeIcon),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => BlocProvider(
                          create: (context) => GetJoinedChannelsCubit(), 
                          child: const JoinedChannelScreen(),
                        )));
              },
              child: CustomDrawerItomWidget(
                  text: 'Added to channels', icon: AppIcons.addedTochannelIcon),
            ),
            CustomDrawerItomWidget(text: 'Chats', icon: AppIcons.chatIcon),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: AppColors.lightTextColor,
              ),
            ),
            CustomDrawerItomWidget(
                text: 'Your channel', icon: AppIcons.userVideoIcon),
            CustomDrawerItomWidget(text: 'History', icon: AppIcons.historyIcon),
            CustomDrawerItomWidget(
                text: 'Liked videos', icon: AppIcons.likedIcon),
            CustomDrawerItomWidget(
                text: 'Watch later', icon: AppIcons.watchLaterIcon),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: AppColors.lightTextColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(
                  text: 'Explore ',
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.normal),
            ),
            CustomDrawerItomWidget(
              text: 'channels',
              icon: Icons.group_work_outlined,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => BlocProvider(
                          create: (context) => GetAllchannelsCubit(),
                          child: const AllChannelsScreen(),
                        )));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                color: AppColors.lightTextColor,
              ),
            ),
            CustomDrawerItomWidget(
                text: 'Settings', icon: AppIcons.settingsIcon),
          ],
        ),
      ),
    );
  }
}
