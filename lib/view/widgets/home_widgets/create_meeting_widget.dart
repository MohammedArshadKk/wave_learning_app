import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/blocs/check%20channel%20created%20or%20not/channel_created_or_not_bloc.dart';

import '../../utils/icons.dart';

class CreateMeetingWidget extends StatelessWidget {
  const CreateMeetingWidget({super.key, required this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final channelState = context.read<ChannelCreatedOrNotBloc>();
        channelState.add(ChekingChannelcreatedEvent(uid: uid));
      },
      child: Column(
        children: [
          ClipOval(
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all()),
              child: Center(
                child: Icon(
                  AppIcons.meetingIcon,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
              text: 'Create Meeting',
              color: AppColors.secondaryColor,
              fontSize: 20,
              fontFamily: Fonts.primaryText,
              fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}
