import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/join_channel_cubit/join_channel_cubit.dart';

class ChannelDetialsWidget extends StatefulWidget {
  const ChannelDetialsWidget(
      {super.key,
      required this.channelName,
      required this.iconUrl,
      required this.totalVideos,
      required this.documentId});
  final String channelName;
  final String iconUrl;
  final String totalVideos;
  final String documentId;

  @override
  State<ChannelDetialsWidget> createState() => _ChannelDetialsWidgetState();
}

class _ChannelDetialsWidgetState extends State<ChannelDetialsWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    context
        .read<JoinChannelCubit>()
        .checkjoinedOrNot(_auth.currentUser!.uid, widget.documentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Container(
              height: 50,
              width: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: Image.network(
                widget.iconUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: widget.channelName,
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.w600),
              CustomText(
                  text: "${widget.totalVideos} members",
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.w500),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context
                    .read<JoinChannelCubit>()
                    .joinChannel(_auth.currentUser!.uid, widget.documentId);
              },
              child: BlocBuilder<JoinChannelCubit, JoinChannelState>(
                builder: (context, state) {
                  if (state is JoinedState) {
                    return CustomContainer(
                      height: 30,
                      width: 70,
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(14),
                      borderColor: Border.all(),
                      child: Center(
                        child: CustomText(
                            text: 'Joined',
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontFamily: Fonts.primaryText,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  } else if (state is UnJoinedState) {
                    return CustomContainer(
                      height: 30,
                      width: 70,
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(14),
                      child: Center(
                        child: CustomText(
                            text: 'join',
                            color: AppColors.backgroundColor,
                            fontSize: 16,
                            fontFamily: Fonts.primaryText,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
