import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startPollingProgress();
  }

  void _startPollingProgress() {
    // Poll every 500ms for updates in SharedPreferences
    Future.delayed(Duration(milliseconds: 500), _updateProgress);
  }

  Future<void> _updateProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _progress = prefs.getDouble('uploadProgress') ?? 0.0;
    });

    // Continue polling
    if (_progress < 1.0) {
      _startPollingProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Progress'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Uploading...'),
            SizedBox(height: 20),
            LinearProgressIndicator(value: _progress),
            SizedBox(height: 20),
            Text('${(_progress * 100).toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }
} 
