import 'dart:async';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/common_screens/custom_bottom_navigation_bar.dart';
import 'package:wave_learning_app/view/screens/web/web_login_screen.dart';
import 'package:wave_learning_app/view/screens/web/web_navigation.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/web/image_auth_web.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';

class WebSplash extends StatefulWidget {
  const WebSplash({super.key});

  @override
  State<WebSplash> createState() => _WebSplashState();
}

class _WebSplashState extends State<WebSplash> {
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
                  builder: (ctx) =>  const WebNavigationScreen())); 
            });
            log('AuthenticatedState');
          } else if (state is UnAuthenticatedState) {
            Timer(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => WebLoginScreen()));
            });
          }
        },
        child: SingleChildScrollView(
          child: Row(
            children: [
              ImageAuthWeb(image: AppImages.welcomeImage),
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
                        RotateAnimatedText('      WELCOME TO'),
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
      ),
    );
  }
}
