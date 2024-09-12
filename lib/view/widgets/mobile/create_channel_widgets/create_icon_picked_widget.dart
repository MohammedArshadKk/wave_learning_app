import 'dart:io';

import 'package:flutter/material.dart';

class CreateIconPickedWidget extends StatelessWidget {
  const CreateIconPickedWidget({super.key, required this.icon});
  final File icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ClipOval(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(),
          ),
          child: Image.file(
            icon,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
