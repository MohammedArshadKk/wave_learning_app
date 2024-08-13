import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/channel%20createtion%20bloc/channel_creation_bloc.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class CreateChannelIconNonSelectedWedget extends StatelessWidget {
  const CreateChannelIconNonSelectedWedget({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return SizedBox(
      height: screenHeight * 0.35,
      width: screenWidth,
      child: InkWell(
        onTap: () {
          context.read<ChannelCreationBloc>().add(IconPickEvent());
        },
        child: Image.asset(AppImages.addChannelIconimage),
      ),
    );
  }
}
