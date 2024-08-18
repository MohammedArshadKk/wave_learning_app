import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveVideoDetailsToPrefs(String title, String videoPath, String thumbnailPath) async {
  final prefs = await SharedPreferences.getInstance();
  final videoDetails = {
    'title': title,
    'videoPath': videoPath,
    'thumbnailPath': thumbnailPath,
  };
  prefs.setString('video_$videoPath', videoDetails.toString());
}
