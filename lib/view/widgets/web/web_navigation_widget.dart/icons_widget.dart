import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';

class IconsWidget extends StatelessWidget {
  const IconsWidget({super.key, required this.icon, required this.size});
  final IconData icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    return Padding(
      padding:  EdgeInsets.all(screenHeight*0.05), 
      child: Icon(
        icon,
        size: size,
        color: AppColors.backgroundColor,
      ),
    );
  }
}
