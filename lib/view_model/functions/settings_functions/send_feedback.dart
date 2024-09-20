import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

void sendFeedback(BuildContext context) async {
  const email = 'arshadkk8590@gmail.com';
  const subject = 'Feedback for Your App';
  const body = 'Enter your feedback here...';
  final emailLaunchUri = Uri(scheme: 'mailto', path: email, queryParameters: {
    'subject': subject,
    'body': body,
  });
  try {
    await launchUrl(emailLaunchUri);
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Could not launch email. Please check your email app",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
