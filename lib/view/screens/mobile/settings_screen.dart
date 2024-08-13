import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_login_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/widgets/settings%20widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/widgets/settings%20widgets/settings_itoms_widgets.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 100,
        title: const AppBarText(),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const SettingsItomsWidgets(
              text: 'share with friends', icon: Icons.share),
          const SettingsItomsWidgets(
              text: 'About as', icon: Icons.info_outline),
          const SettingsItomsWidgets(
              text: 'Privacy policy', icon: Icons.privacy_tip_outlined),
          const SettingsItomsWidgets(
              text: 'Feedback', icon: Icons.feed_outlined),
          const SettingsItomsWidgets(
              text: 'Terms and conditions ', icon: Icons.gavel_outlined),
          const SettingsItomsWidgets(
              text: 'Notifications', icon: Icons.notifications_on_outlined),
          GestureDetector(
              onTap: () async {
                await _auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (ctx) => const MobileLoginScreen()),
                  (route) => false,
                );
              },
              child: const SettingsItomsWidgets(
                  text: 'Logout', icon: Icons.logout)),
        ],
      ),
    );
  }
}
