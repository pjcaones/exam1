import 'package:core/core.dart';
import 'package:data/src/datasources/datasources.dart';
import 'package:domain/domain.dart';
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
