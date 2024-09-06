import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';

class SearchResultsVideosScreen extends StatelessWidget {
  const SearchResultsVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        toolbarHeight: 100,
      ),
      
    );
  }
}
