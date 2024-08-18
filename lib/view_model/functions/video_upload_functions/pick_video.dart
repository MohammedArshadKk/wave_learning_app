import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickVideo() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.video, allowMultiple: false);
  return result;
}
