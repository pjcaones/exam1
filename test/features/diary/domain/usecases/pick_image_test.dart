import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:exam1/features/diary/domain/repositories/pick_image_repository.dart';
import 'package:exam1/features/diary/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockPickImageRepository extends Mock implements PickImageRepository {}

void main() {
  final XFile tXFile = XFile('Sample.png');

  final MockPickImageRepository mockPickImageRepository =
      MockPickImageRepository();

  const ImageDetails tImageDetails = ImageDetails(
    imageSource: ImageSource.gallery,
  );

  group('use case of pick image', () {
    final pickImage = PickImage(pickImageRepository: mockPickImageRepository);

    test('should success pick image', () async {
      when(
        () => mockPickImageRepository.getPickedImage(
          imageDetails: tImageDetails,
        ),
      ).thenAnswer((_) async => Right(tXFile));

      final result = await pickImage(
        tImageDetails,
      );

      verify(
        () => mockPickImageRepository.getPickedImage(
          imageDetails: tImageDetails,
        ),
      );

      expect(result, Right(tXFile));
    });

    test('should fail pick image', () async {
      when(
        () => mockPickImageRepository.getPickedImage(
          imageDetails: tImageDetails,
        ),
      ).thenAnswer((_) async => Left(PickImageFailure()));

      final result = await pickImage(
        tImageDetails,
      );

      verify(
        () => mockPickImageRepository.getPickedImage(
          imageDetails: tImageDetails,
        ),
      );

      expect(result, Left(PickImageFailure()));
    });
  });

  // group('actual pick image', () {
  //   final pickImage = PickImage(pickImageRepository: )

  //   test('should success', () async {});
  // });
}
