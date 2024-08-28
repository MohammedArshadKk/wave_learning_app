import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

BetterPlayerController videoConfigtration(String videoUrl) {
  BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    BetterPlayerDataSourceType.network,
    videoUrl,
    bufferingConfiguration: const BetterPlayerBufferingConfiguration(
      minBufferMs: 5000,
      maxBufferMs: 13107200,
      bufferForPlaybackMs: 1000,
      bufferForPlaybackAfterRebufferMs: 5000,
    ),
  );

  return BetterPlayerController(
    const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.fitHeight,
    ),
    betterPlayerDataSource: betterPlayerDataSource,
  );
}
