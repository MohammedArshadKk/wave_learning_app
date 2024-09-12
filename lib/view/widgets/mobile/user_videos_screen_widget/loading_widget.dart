import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wave_learning_app/view/utils/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                height: 100, 
                width: 200,
                color: AppColors.alertColor,    
              ),
            );
          },
        ),
      ),
    );
  }
}
