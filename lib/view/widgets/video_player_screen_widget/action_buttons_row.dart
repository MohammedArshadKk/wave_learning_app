import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/video_player_screen_widget/action_button_widget.dart';
import 'package:wave_learning_app/view_model/blocs/like_blocs/like_bloc.dart';
import 'package:wave_learning_app/view_model/cubits/watch_later_cubit/watch_later_cubit.dart';

class ActionButtonsRow extends StatefulWidget {
  const ActionButtonsRow({super.key, required this.documentid});
  final String documentid;

  @override
  State<ActionButtonsRow> createState() => _ActionButtonsRowState();
}

class _ActionButtonsRowState extends State<ActionButtonsRow> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    context.read<LikeBloc>().add(CheckLikedEvent(
        uid: _auth.currentUser!.uid, documentid: widget.documentid));
    context
        .read<WatchLaterCubit>()
        .checkSavedToWatchLater(_auth.currentUser!.uid, widget.documentid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        children: [
          BlocBuilder<LikeBloc, LikeState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<LikeBloc>().add(LikeButtonclickedEvent(
                      uid: _auth.currentUser!.uid,
                      documentid: widget.documentid));
                },
                child: state is LikedState
                    ? const ActionButtonWidget(
                        icon: Icons.thumb_up_alt,
                      )
                    : const ActionButtonWidget(
                        icon: Icons.thumb_up_alt_outlined,
                      ),
              );
            },
          ),
          const SizedBox(
            width: 58,
          ),
          BlocBuilder<WatchLaterCubit, WatchLaterState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<WatchLaterCubit>().watchLaterButtonCliked(
                      _auth.currentUser!.uid, widget.documentid);
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: state is AddedwatchLaterState ?AppColors.alertColor:Colors.green,
                      content: CustomText(
                          text: state is AddedwatchLaterState
                              ? 'This video has been removed from your watch later list.'
                              : 'This video has been added to your watch later list.',
                          color: AppColors.backgroundColor,
                          fontSize: 16, 
                          fontFamily: Fonts.labelText,
                          fontWeight: FontWeight.w500))); 
                },
                child: state is AddedwatchLaterState
                    ? const ActionButtonWidget(icon: Icons.bookmark)
                    : const ActionButtonWidget(
                        icon: Icons.bookmark_outline_outlined,
                      ),
              );
            },
          ),
          const SizedBox(
            width: 50,
          ),
          const ActionButtonWidget(
            icon: Icons.share,
          ),
        ],
      ),
    );
  }
}
