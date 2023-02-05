import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/core/usecases/usecases.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:exam1/features/diary/domain/repositories/pick_image_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

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
