import 'package:flutter/material.dart';

class AboutImageWidget extends StatelessWidget {
  const AboutImageWidget({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipOval(
        child: Container(
          height: 200,
          width: 200,
          decoration:
              BoxDecoration(shape: BoxShape.circle, border: Border.all()),
          child: Image.network(
            icon,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
