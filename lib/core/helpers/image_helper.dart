import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  Future<XFile?> pickImage(
      {required ImageSource source,
      double maxWidth = 500,
      double maxHeight = 500,
      int quality = 80}) async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? pickedFile = await picker.pickImage(
          source: source,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          imageQuality: quality);

      //Other manipulation here for the image here there are need to be adjusted to the image..

      return pickedFile;
    } catch (error) {
      log('pickImage error: $error');
    }

    return null;
  }
}
