import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<String> generateThumbnail(String videoPath) async {
  final uint8list = await VideoThumbnail.thumbnailData(
    video: videoPath,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 512, 
    maxHeight: 512, 
    quality: 90, 
  );

  final tempDir = await getTemporaryDirectory();
  final thumbnailFile = File('${tempDir.path}/thumbnail.jpg');
  await thumbnailFile.writeAsBytes(uint8list!);

  return thumbnailFile.path;
}
