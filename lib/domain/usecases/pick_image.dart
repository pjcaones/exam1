import 'dart:developer';

import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/core/usecases/usecases.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

class PickImage implements UseCase<XFile, ImageSource> {
  final ImageHelper imageHelper;

  PickImage({required this.imageHelper});

  @override
  Future<Either<Failure, XFile>> call(ImageSource imageSource) async {
    //Should this be in data folder under repository implementations?
    try {
      final pickedImage = await imageHelper.pickImage(source: imageSource);

      if (pickedImage != null) {
        return Right(pickedImage);
      } else {
        return Left(PickImageFail());
      }
    } catch (error) {
      log('_pickImage error: $error');
      return Left(PickImageFail());
    }
  }
}
