import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Terms & Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Introduction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Welcome to the Wave Learning App. By accessing or using our application, you agree to be bound by these terms and conditions ("Terms"). Please read them carefully before creating an account or uploading any content.',
              ),
              SizedBox(height: 16),
              Text(
                '2. Account Creation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Users must create an account to access certain features of the app, including creating channels and uploading content. Users agree to provide accurate and up-to-date information during the account creation process.',
              ),
              SizedBox(height: 16),
              Text(
                '3. Educational Content Only',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'The Wave Learning App is strictly for educational purposes. All videos uploaded must be relevant to education and learning. Entertainment, inappropriate, or irrelevant content is strictly prohibited.',
              ),
              // Add more sections as necessary
              SizedBox(height: 16),
              Text(
                '4. Channel Creation and Usage',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Users may create channels to upload and share educational content. Users are responsible for the content uploaded to their channels and must ensure compliance with these Terms.',
              ),
              SizedBox(height: 16),
              Text(
                '5. Prohibited Content',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Any form of entertainment content, including but not limited to movies, music videos, or gaming content, is not allowed.',
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
