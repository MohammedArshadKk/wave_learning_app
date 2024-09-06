import 'dart:developer';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

openDoc(String docUrl) async {
  try {
    final tempDirectory = await getTemporaryDirectory();
    final filePath = '${tempDirectory.path}/downloaded_file.pdf';
    final response = await http.get(Uri.parse(docUrl));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      final result = await OpenFile.open(filePath);

      log('File opened successfully');
    }
  } catch (e) {
    log('Error downloading or opening file: $e');
  }
}
