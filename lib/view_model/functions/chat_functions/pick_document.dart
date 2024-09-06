
import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickDocument() async {
   FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowMultiple: false,
                    allowedExtensions: [
                      'pdf',
                      'doc',
                      'docx',
                      'xls',
                      'xlsx',
                      'ppt',
                      'pptx'
                    ],
                  );
  return result;
}
