import 'dart:developer';

import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/features/diary/data/datasources/pick_image_datasource.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:exam1/features/diary/domain/repositories/repositories.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

class PickedImageRepositoryImpl implements PickImageRepository {
  const PickedImageRepositoryImpl({
    required this.pickImageDataSource,
  });
  final PickImageDataSource pickImageDataSource;

  @override
  Future<Either<PickImageFailure, XFile>> getPickedImage(
      {required ImageDetails imageDetails}) async {
    final pickedImage = await pickImageDataSource.getPickedImage(
      imageDetails: imageDetails,
    );

    if (pickedImage != null) {
      return Right(pickedImage);
    } else {
      return Left(PickImageFailure());
    }
  }
}
