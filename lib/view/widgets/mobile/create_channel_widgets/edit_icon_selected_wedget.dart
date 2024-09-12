import 'dart:io';

import 'package:flutter/material.dart';

class EditIconSelectedWedget extends StatefulWidget {
  const EditIconSelectedWedget({super.key, required this.icon});
  final File icon;

  @override
  State<EditIconSelectedWedget> createState() => _EditIconSelectedWedgetState();
}

class _EditIconSelectedWedgetState extends State<EditIconSelectedWedget> {
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
            widget.icon,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
