import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/channel%20createtion%20bloc/channel_creation_bloc.dart';

class EditIconNonSelectedWedget extends StatelessWidget {
  const EditIconNonSelectedWedget({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ChannelCreationBloc>().add(IconPickEvent());
      },
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: ClipOval(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Image.network(
              icon,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
