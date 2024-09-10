import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view_model/blocs/bottom%20navigation%20bloc/bottom_navigation_bloc_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/home_screen.dart';
import 'package:wave_learning_app/view/screens/mobile/chat_bot_screen.dart';
import 'package:wave_learning_app/view/screens/mobile/chat_groups_screen.dart';
import 'package:wave_learning_app/view/screens/mobile/profile_screen.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, });

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const HomeScreen(),
      BlocProvider(
        create: (context) => GetJoinedChannelsCubit(),
        child: const ChatGroupScreen(),
      ),
       ChatBotScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<BottomNavigationBlocBloc, BottomNavigationBlocState>(
          builder: (context, state) {
        int currentIndex =
            (state is ItemSelectedstate) ? state.selectedIndex : 0;

        return screens[currentIndex];
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomContainer(
          height: 80,
          width: double.infinity,
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: AppColors.backgroundColor,
                  size: 30,
                ),
                onPressed: () {
                  context
                      .read<BottomNavigationBlocBloc>()
                      .add(ItemClickedEvent(0));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.chat_outlined,
                  color: AppColors.backgroundColor,
                  size: 25,
                ),
                onPressed: () {
                  context
                      .read<BottomNavigationBlocBloc>()
                      .add(ItemClickedEvent(1));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.smart_toy_outlined,
                  color: AppColors.backgroundColor,
                  size: 30,
                ),
                onPressed: () {
                  context
                      .read<BottomNavigationBlocBloc>()
                      .add(ItemClickedEvent(2));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.backgroundColor,
                  size: 30,
                ),
                onPressed: () {
                  context
                      .read<BottomNavigationBlocBloc>()
                      .add(ItemClickedEvent(3));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
