import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:wave_learning_app/view/screens/mobile/search_video_screen.dart';
import 'package:wave_learning_app/view/screens/web/web_chat_bot_screen.dart';
import 'package:wave_learning_app/view/screens/web/web_chat_screen.dart';
import 'package:wave_learning_app/view/screens/web/web_home_screen.dart';
import 'package:wave_learning_app/view/screens/web/web_profile_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/mobile/home_widgets/drawer_widget.dart';
import 'package:wave_learning_app/view/widgets/web/user_info_widget.dart';
import 'package:wave_learning_app/view/widgets/web/web_navigation_widget.dart/icons_widget.dart';
import 'package:wave_learning_app/view/widgets/web/web_navigation_widget.dart/search_bar_widget.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/search_videos_cubit/search_videos_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/web_navigation_cubit/web_navigation_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/web_selecte_group_cubit/web_selecte_group_cubit.dart';

class WebNavigationScreen extends StatefulWidget {
  const WebNavigationScreen({super.key, this.index});
  final int? index;
  @override
  State<WebNavigationScreen> createState() => _WebNavigationScreenState();
}

class _WebNavigationScreenState extends State<WebNavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> webScreens = [
      const WebHomeScreen(),
      BlocProvider(
        create: (context) => WebSelecteGroupCubit(),
        child: const WebChatScreen(),
      ),
      const WebChatBotScreen(),
      const WebProfileScreen()
    ];
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    double iconSize = screenWidth * 0.02;
    double sidebarWidth = screenWidth * 0.08;
    double topContainerHeight = screenHeight * 0.14;
    double bottomContainerHeight = screenHeight * 0.67;
    double dividerThickness = screenHeight * 0.002;
    double borderRadius = 10;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: _scaffoldKey,
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.02, top: screenHeight * 0.05),
            child: Column(
              children: [
                CustomContainer(
                  height: topContainerHeight,
                  width: sidebarWidth,
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Center(
                    child: GestureDetector(
                      onTap: _openDrawer,
                      child: IconsWidget(
                        icon: Icons.menu,
                        size: iconSize,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomContainer(
                  height: bottomContainerHeight,
                  width: sidebarWidth,
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.read<WebNavigationCubit>().itemSelected(0);
                          },
                          child: IconsWidget(
                              icon: AppIcons.homeIcon, size: iconSize)),
                      Divider(
                          color: AppColors.backgroundColor,
                          thickness: dividerThickness),
                      GestureDetector(
                          onTap: () {
                            context.read<WebNavigationCubit>().itemSelected(1);
                          },
                          child: IconsWidget(
                              icon: AppIcons.chatIcon, size: iconSize)),
                      Divider(
                          color: AppColors.backgroundColor,
                          thickness: dividerThickness),
                      GestureDetector(
                        onTap: () {
                          context.read<WebNavigationCubit>().itemSelected(2);
                        },
                        child: IconsWidget(
                            icon: Icons.smart_toy_outlined, size: iconSize),
                      ),
                      Divider(
                          color: AppColors.backgroundColor,
                          thickness: dividerThickness),
                      GestureDetector(
                          onTap: () {
                            context.read<WebNavigationCubit>().itemSelected(3);
                          },
                          child: IconsWidget(
                              icon: Icons.person_rounded, size: iconSize)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => BlocProvider(
                                      create: (context) => SearchVideosCubit(),
                                      child: SearchVideoScreen(),
                                    )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(24),
                              border:
                                  Border.all(color: AppColors.lightTextColor),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Icon(Icons.search,
                                      color: AppColors.lightTextColor),
                                  SizedBox(width: 8),
                                  Text(
                                    'Search...',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      _buildCircularButton(
                        Icons.search,
                        screenHeight,
                        screenWidth,
                        () {},
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      _buildCircularButton(
                        Icons.account_circle,
                        screenHeight,
                        screenWidth,
                        () {
                          showTopModalSheet(context, UserInfoWidget());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Expanded(
                    child: BlocProvider(
                      create: (context) => GetJoinedChannelsCubit(),
                      child:
                          BlocBuilder<WebNavigationCubit, WebNavigationState>(
                        builder: (context, state) {
                          int index =
                              (state is WebItemSelectedstate) ? state.index : 0;
                          return webScreens[index];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, double screenHeight,
      double screenWidth, Function()? onPressed) {
    return Container(
      height: screenHeight * 0.075,
      width: screenWidth * 0.05,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: AppColors.backgroundColor),
        ),
      ),
    );
  }
}
