import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
   CustomContainer(
      {super.key,
      required this.height,
      required this.width,
       this.child,
      this.color,
      this.borderRadius,
      this.borderColor,
      });
  final double height;
  final double width;
  Widget? child;
  Color? color;
  BorderRadius? borderRadius;
  Border? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: borderRadius, border: borderColor),
      child: child,
    );
  }
}
