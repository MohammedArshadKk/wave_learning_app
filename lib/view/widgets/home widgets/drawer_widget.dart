import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_drawer_itom_widget.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

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
              CustomDrawerItomWidget(
                  text: 'Added to channels', icon: AppIcons.addedTochannelIcon),
              CustomDrawerItomWidget(text: 'Chats', icon: AppIcons.chatIcon),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: AppColors.lightTextColor,
                ),
              ),
              CustomDrawerItomWidget(
                  text: 'Your channel', icon: AppIcons.userVideoIcon),
              CustomDrawerItomWidget(
                  text: 'History', icon: AppIcons.historyIcon),
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
                    text: 'Explore',
                    color: AppColors.secondaryColor,
                    fontSize: 20,
                    fontFamily: Fonts.labelText,
                    fontWeight: FontWeight.normal),
              ),
              CustomDrawerItomWidget(
                  text: 'create meeting', icon: AppIcons.meetingIcon),
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