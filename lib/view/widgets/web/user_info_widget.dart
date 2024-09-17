import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';

class UserInfoWidget extends StatelessWidget {
  UserInfoWidget({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.8,
        top: screenHeight * 0.16,
      ),
      child: CustomContainer(
        height: screenHeight * 0.3,
        width: screenWidth * 0.17,
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        borderColor: Border.all(color: AppColors.lightTextColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.lightTextColor,
              child: _auth.currentUser?.photoURL != null
                  ? ClipOval(
                      child: Image.network(
                        _auth.currentUser!.photoURL!,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildFallbackAvatar(),
                      ),
                    )
                  : _buildFallbackAvatar(),
            ),
            const SizedBox(height: 10),
            Text(
              _auth.currentUser?.email ?? 'No email',
              style: const TextStyle(
                color: AppColors.lightTextColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Text(
      _auth.currentUser?.email?.isNotEmpty == true
          ? _auth.currentUser!.email![0].toUpperCase()
          : '?',
      style: TextStyle(
        color: AppColors.backgroundColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}