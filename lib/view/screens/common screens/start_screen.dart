import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/common%20screens/splash_screen.dart';
import 'package:wave_learning_app/view/screens/web/web_login_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1000) {
        return const WebLoginScreen();
      } else {
        return const SplashScreen();
      }
    });
  }
}
