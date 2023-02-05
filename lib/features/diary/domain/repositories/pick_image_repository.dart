import 'package:exam1/core/errors/errors.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';

import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

abstract class PickImageRepository {
  Future<Either<PickImageFailure, XFile>> getPickedImage(
      {required ImageDetails imageDetails});
}
