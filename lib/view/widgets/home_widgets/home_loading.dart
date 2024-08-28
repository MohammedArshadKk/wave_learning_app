import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wave_learning_app/view/utils/colors.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(  
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              height: 300, 
              width: double.infinity,
              color: AppColors.alertColor,    
            ),
          );
        },
      ),
    );
  }
}