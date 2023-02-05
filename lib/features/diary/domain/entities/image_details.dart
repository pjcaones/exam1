import 'package:image_picker/image_picker.dart';

class ImageDetails {
  const ImageDetails({
    required this.imageSource,
    this.maxHeight = 500,
    this.maxWidth = 500,
    this.quality = 80,
  });

  final ImageSource imageSource;
  final double maxHeight;
  final double maxWidth;
  final int quality;
}
