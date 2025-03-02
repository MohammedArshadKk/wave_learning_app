import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.videoFile});
  final File videoFile;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  @override
  void initState() {
    initializeChewiePlayer();
    super.initState();
  }

  Future<void> initializeChewiePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.file(widget.videoFile);
      await _videoPlayerController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
      );
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: (_chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : const Center(child: CircularProgressIndicator())))),
    );
  }
}
