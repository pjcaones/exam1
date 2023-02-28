import 'package:core/core.dart';
import 'package:domain/src/entities/entities.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

abstract class PickImageRepository {
  Future<Either<PickImageFailure, XFile>> getPickedImage({
    required ImageDetails imageDetails,
  });
}
