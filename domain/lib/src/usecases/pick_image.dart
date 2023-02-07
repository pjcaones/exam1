import 'package:core/core.dart';
import 'package:domain/src/entities/entities.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/repositories.dart';

class PickImage implements UseCase<XFile, ImageDetails> {
  PickImage({required this.pickImageRepository});
  final PickImageRepository pickImageRepository;

  @override
  Future<Either<Failure, XFile>> call(ImageDetails imageDetails) async {
    return pickImageRepository.getPickedImage(
      imageDetails: imageDetails,
    );
  }
}
