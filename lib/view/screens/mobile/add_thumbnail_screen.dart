import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/view/screens/mobile/user_videos_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_button.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/widgets/mobile/video_upload_widgets/add_thumbnail_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/video_upload_widgets/app_bar_title.dart';
import 'package:wave_learning_app/view_model/cubits/background_service_cubit/video_upload_background_cubit.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';

class AddThumbnailScreen extends StatefulWidget {
  const AddThumbnailScreen({
    super.key,
    required this.titleController,
    required this.videoDescriptionController,
    required this.tagsController,
    required this.videoFile,
  });

  final TextEditingController titleController;
  final TextEditingController videoDescriptionController;
  final TextEditingController tagsController;
  final File videoFile;

  @override
  State<AddThumbnailScreen> createState() => _AddThumbnailScreenState();
}

class _AddThumbnailScreenState extends State<AddThumbnailScreen> {
  bool isPaid = false;
  final amountController = TextEditingController();
  File? thumbnail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const AppBarTitle(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              BlocListener<VideoUploadingBloc, VideoUploadingState>(
                listener: (context, state) {
                  if (state is ThumbnailPikedState) {
                    thumbnail = state.thumbnailPath;
                  } else if (state is VideoPikingLoadingState) {
                    customLoading(context);
                  } else if (state is ThumbnailGeneratedState) {
                    Navigator.pop(context);
                    thumbnail = File(state.thumbnail);
                    _startUpload(context, thumbnail!, widget.videoFile);
                  } else if (state is VideoUploadLoadingState) {
                    customLoading(context);
                  } else if (state is VideodetailsUploadedState) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => UserVideosScreen()));
                  }
                },
                child: const AddThumbnailWidget(),
              ),
              const SizedBox(height: 24),
              Text(
                'Video Access Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isPaid = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isPaid
                              ? AppColors.primaryColor
                              : AppColors.settingsColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Free',
                            style: TextStyle(
                              color: !isPaid
                                  ? AppColors.backgroundColor
                                  : AppColors.lightTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isPaid = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isPaid
                              ? AppColors.primaryColor
                              : AppColors.settingsColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Premium',
                            style: TextStyle(
                              color: isPaid
                                  ? AppColors.backgroundColor
                                  : AppColors.lightTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (isPaid) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: AppColors.secondaryColor),
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    hintStyle: TextStyle(color: AppColors.lightTextColor),
                    filled: true,
                    fillColor: AppColors.settingsColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  if (thumbnail == null) {
                    context.read<VideoUploadingBloc>().add(
                        GenerateThumbnailesEvent(
                            videoPath: widget.videoFile.path));
                  } else {
                    _startUpload(context, thumbnail!, widget.videoFile);
                  }
                },
                child: const CustomButton(
                  text: 'Upload Video',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startUpload(BuildContext context, File thumbnail, File videoFile) {
    final cubit = context.read<VideoUploadBackgroundCubit>();
    final tagsText = widget.tagsController.text;
    final tags = tagsText.trim().split(',').toList();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final videoModel = VideoModel(
      title: widget.titleController.text,
      description: widget.videoDescriptionController.text,
      tags: tags,
      uid: auth.currentUser!.uid,
      channelName: 'channelName',
      email: auth.currentUser!.email.toString(),
      likes: [],
      videoUrl: '',
      thumbnailUrl: '',
      time: DateTime.now().toString(),
      watchLater: [],
      views: [],
      hasPayment: isPaid,
      price: isPaid ? amountController.text : '0.0',
      isUploaded: false,
      videoPath: videoFile.path,
    );

    context.read<VideoUploadingBloc>().add(UploadVideoEvent(
          videoModel: videoModel,
          thumbnailPath: thumbnail.path,
          videoPath: videoFile.path,
        ));
  }
}
