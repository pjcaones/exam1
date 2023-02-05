import 'dart:developer';

import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:image_picker/image_picker.dart';

abstract class PickImageDataSource {
  Future<XFile?> getPickedImage({
    required ImageDetails imageDetails,
  });
}

class PickImageDataSourceImpl implements PickImageDataSource {
  PickImageDataSourceImpl({
    required this.picker,
  });

  final ImagePicker picker;

  @override
  Future<XFile?> getPickedImage({
    required ImageDetails imageDetails,
  }) async {
    final XFile? pickedFile = await picker.pickImage(
        source: imageDetails.imageSource,
        maxHeight: imageDetails.maxHeight,
        maxWidth: imageDetails.maxWidth,
        imageQuality: imageDetails.quality);

    return pickedFile;
  }
}
