import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontFamily,
    required this.fontWeight,
  });
  final String text;
  final Color color;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        overflow: TextOverflow.visible, 
      ),
    );
  }
}
