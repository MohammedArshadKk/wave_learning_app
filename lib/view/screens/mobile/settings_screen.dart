import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave_learning_app/view/screens/common_screens/terms_and_conditions_screen.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_login_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/widgets/mobile/settings_widgets/settings_itoms_widgets.dart';
import 'package:wave_learning_app/view_model/functions/settings_functions/send_feedback.dart';

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
        title: const Center(
            child: AppBarText(
          text: 'Settings',
        )),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Share.share('https://console.firebase.google.com');
              },
              child: const SettingsItomsWidgets(
                  text: 'share with friends', icon: Icons.share),
            ),
            const SettingsItomsWidgets(
                text: 'About as', icon: Icons.info_outline),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(
                    'https://www.termsfeed.com/live/bb91447f-227b-4ef8-a093-b1bf9ed6cf54'));
              },
              child: const SettingsItomsWidgets(
                  text: 'Privacy policy', icon: Icons.privacy_tip_outlined),
            ),
            GestureDetector(
              onTap: () {
                sendFeedback(context);
              },
              child: const SettingsItomsWidgets(
                  text: 'Feedback', icon: Icons.feed_outlined),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const TermsAndConditionsScreen()));
              },
              child: const SettingsItomsWidgets(
                  text: 'Terms and conditions ', icon: Icons.gavel_outlined),
            ),
            GestureDetector(
                onTap: () async {
                  PanaraConfirmDialog.show(context,
                      message: 'Are you sure you want to logout?',
                      confirmButtonText: 'Logout',
                      cancelButtonText: "cancel", onTapConfirm: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (ctx) => const MobileLoginScreen()),
                      (route) => false,
                    );
                  }, onTapCancel: () {
                    Navigator.pop(context);
                  }, panaraDialogType: PanaraDialogType.error);
                },
                child: const SettingsItomsWidgets(
                    text: 'Logout', icon: Icons.logout)),
          ],
        ),
      ),
    );
  }
}
