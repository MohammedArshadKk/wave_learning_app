import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wave_learning_app/model/playlist_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_button.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/create_playlist_cubit/create_playlist_cubit.dart';

void showModelBottomSheet(BuildContext context,
    TextEditingController playlistNameController, String uid) {
  showMaterialModalBottomSheet(
    context: context,
    builder: (ctx) => AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
      child: CustomContainer(
        height: 350,
        width: double.infinity,
        color: AppColors.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                  text: 'Create New Playlist',
                  color: AppColors.secondaryColor,
                  fontSize: 20,
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.w600),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: 'Enter playlist name',
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal,
                padding: 20,
                fontSize: 16,
                textColor: AppColors.lightTextColor,
                paddingForm: 20,
                borderRadius: 10,
                controller: playlistNameController,
              ),
              const SizedBox(height: 30),
              BlocListener<CreatePlaylistCubit, CreatePlaylistState>(
                listener: (context, state) {
                  if (state is CreatedState) {
                  context.read<CreatePlaylistCubit>().getPlaylists(uid);
                    Navigator.pop(context);
                    playlistNameController.clear();

                    Navigator.pop(context);
                  } else if (state is LoadingState) {
                    customLoading(context);
                  }
                },
                child: GestureDetector(
                    onTap: () {
                      if (playlistNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('please enter playlist name')));
                      } else {
                        final PlaylistModel playlist = PlaylistModel(
                            playlistName: playlistNameController.text,
                            uid: uid,
                            videos: []);

                        context
                            .read<CreatePlaylistCubit>()
                            .createPlaylist(playlist);
                      }
                    },
                    child: const CustomButton(text: 'Create')),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
