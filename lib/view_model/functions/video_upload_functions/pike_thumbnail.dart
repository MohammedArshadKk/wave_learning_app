import 'package:image_picker/image_picker.dart';

Future<XFile?> pickThumbnail() async {
  final ImagePicker pickThumbnaileImage = ImagePicker();

  final pickIcon =
      await pickThumbnaileImage.pickImage(source: ImageSource.gallery);

  return pickIcon;
}
