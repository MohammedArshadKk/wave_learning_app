import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/screens/common%20screens/custom_bottom_navigation_bar.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_login_screen.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_image_asset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
   context.read<AuthenticationBloc>().add(CheckLoginStatusEvent());
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Timer(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => const CustomBottomNavigationBar()));
            });
          } else if (state is UnAuthenticatedState) {
            Timer(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const MobileLoginScreen()));
            });
          }
        },
        child: Column(
          children: [
            CustomImageAsset(
              image: AppImages.welcomeImage,
              height: 400,
              width: double.infinity,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 20.0, height: 100.0),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColors.primaryColor,
                    fontFamily: Fonts.spalshText,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('WELCOME TO'),
                      RotateAnimatedText('WAVE LEARNING APP'),
                    ],
                    repeatForever: true,
                    pause: const Duration(microseconds: 100),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
