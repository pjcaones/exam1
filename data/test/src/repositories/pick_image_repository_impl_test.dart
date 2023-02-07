import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockPickImageDataSource extends Mock implements PickImageDataSource {}

void main() {
  final tXFile = XFile('sample.png');
  final mockPickImageDataSource = MockPickImageDataSource();
  late PickedImageRepositoryImpl pickedImageRepositoryImpl;

  const ImageDetails tImageDetails = ImageDetails(
    imageSource: ImageSource.gallery,
  );

  group('pick image repository impl', () {
    test('should success', () async {
      when(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      ).thenAnswer((_) async => tXFile);

      pickedImageRepositoryImpl = PickedImageRepositoryImpl(
        pickImageDataSource: mockPickImageDataSource,
      );

      final result = await pickedImageRepositoryImpl.getPickedImage(
          imageDetails: tImageDetails);

      verify(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      );

      expect(result, Right(tXFile));
    });

    test('should fail', () async {
      when(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      ).thenAnswer((_) async => null);

      pickedImageRepositoryImpl = PickedImageRepositoryImpl(
        pickImageDataSource: mockPickImageDataSource,
      );

      final result = await pickedImageRepositoryImpl.getPickedImage(
          imageDetails: tImageDetails);

      verify(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      );

      expect(result, Left(PickImageFailure()));
    });
  });
}
