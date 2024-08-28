import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/model/video_model.dart';
import 'package:wave_learning_app/services/repositories/channel%20services/get_channel.dart';
import 'package:wave_learning_app/view/screens/mobile/channel_screen.dart';
import 'package:wave_learning_app/view/widgets/user_videos_screen_widget/loading_widget.dart';
import 'package:wave_learning_app/view/widgets/video_player_screen_widget/action_buttons_row.dart';
import 'package:wave_learning_app/view/widgets/video_player_screen_widget/channel_detials_widget.dart';
import 'package:wave_learning_app/view/widgets/video_player_screen_widget/description_widget.dart';
import 'package:wave_learning_app/view/widgets/video_player_screen_widget/time_diff_widget.dart';
import 'package:wave_learning_app/view/widgets/video_player_screen_widget/title_widget.dart';
import 'package:wave_learning_app/view_model/blocs/like_blocs/like_bloc.dart';
import 'package:wave_learning_app/view_model/cubits/join_channel_cubit/join_channel_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/watch_later_cubit/watch_later_cubit.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/init_functions/video_player_init_function.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.videoModel,
    required this.timeDiff,
  });
  final VideoModel videoModel;
  final String timeDiff;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late BetterPlayerController betterPlayerController;
  @override
  void initState() {
    betterPlayerController = videoConfigtration(widget.videoModel.videoUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(controller: betterPlayerController),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleWidget(title: widget.videoModel.title),
                    const SizedBox(
                      height: 20,
                    ),
                    TimeDiffWidget(difference: widget.timeDiff),
                    FutureBuilder(
                        future: getChannel(widget.videoModel.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LoadingWidget();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Text('No channel data available');
                          } else {
                            final docSnapshot = snapshot.data!.docs[0];
                            final data =
                                docSnapshot.data() as Map<String, dynamic>;
                            final String documentId = docSnapshot.id;

                            final ChannelModel channelModel =
                                ChannelModel.formMap(
                              data,
                              documentId: documentId,
                            );
                            return BlocProvider(
                              create: (context) => JoinChannelCubit(),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (ctx) => ChannelScreen(
                                                channelModel: channelModel,
                                              )));
                                },
                                child: ChannelDetialsWidget(
                                  channelName: channelModel.channelName,
                                  iconUrl:
                                      channelModel.channelIconUrl.toString(),
                                  totalVideos:
                                      channelModel.members.length.toString(),
                                  documentId:
                                      channelModel.documentId.toString(),
                                ),
                              ),
                            );
                          }
                        }),
                    MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => LikeBloc(),
                        ),
                        BlocProvider(
                          create: (context) => WatchLaterCubit(),
                        ),
                      ],
                      child: ActionButtonsRow(
                        documentid: widget.videoModel.documentid.toString(),
                      ),
                    ),
                    DescriptionWidget(
                      description: widget.videoModel.description,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    betterPlayerController.dispose();
    super.dispose();
  }
}
