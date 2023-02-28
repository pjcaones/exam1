import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockPickImageDataSource extends Mock implements PickImageDataSource {}

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  final MockPickImageDataSource mockPickImageDataSource =
      MockPickImageDataSource();

  const ImageDetails tImageDetails = ImageDetails(
    imageSource: ImageSource.gallery,
  );

  group('mock pick image', () {
    final XFile tXFile = XFile('Sample.png');

    test('should success pick image', () async {
      when(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      ).thenAnswer((_) async => tXFile);

      final result = await mockPickImageDataSource.getPickedImage(
        imageDetails: tImageDetails,
      );

      verify(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      );

      expect(result, tXFile);
    });

    test('should nothing pick', () async {
      when(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      ).thenAnswer((_) async => null);

      final result = await mockPickImageDataSource.getPickedImage(
        imageDetails: tImageDetails,
      );

      verify(
        () => mockPickImageDataSource.getPickedImage(
          imageDetails: tImageDetails,
        ),
      );

      expect(result, null);
    });
  });

  group('actual pick of image', () {
    final actualFile = XFile(
      '/Users/jpcaones/Library/Developer/CoreSimulator/Devices/EE8D9367-6B36-4497-9C67-E7A299A373A5/data/Containers/Data/Application/8908687F-BBCC-4C55-82CA-62EC1595CCF6/tmp/image_picker_1876576C-4AFB-413B-9D59-C8B5E7050B9B-18115-0000003FBEA874E1.jpg',
    );
    final mockImagePicker = MockImagePicker();
    late PickImageDataSourceImpl pickImageDataSourceImpl;

    test('should success the actual picking of image', () async {
      when(
        () => mockImagePicker.pickImage(
          source: tImageDetails.imageSource,
          maxHeight: tImageDetails.maxHeight,
          maxWidth: tImageDetails.maxWidth,
          imageQuality: tImageDetails.quality,
        ),
      ).thenAnswer((_) async => actualFile);

      pickImageDataSourceImpl =
          PickImageDataSourceImpl(picker: mockImagePicker);

      final result = await pickImageDataSourceImpl.getPickedImage(
        imageDetails: tImageDetails,
      );

      verify(
        () => mockImagePicker.pickImage(
          source: tImageDetails.imageSource,
          maxHeight: tImageDetails.maxHeight,
          maxWidth: tImageDetails.maxWidth,
          imageQuality: tImageDetails.quality,
        ),
      );

      expect(result, actualFile);
    });

    test(
      '''
should return null when failed or error''',
      () async {
        when(
          () => mockImagePicker.pickImage(
            source: tImageDetails.imageSource,
            maxHeight: tImageDetails.maxHeight,
            maxWidth: tImageDetails.maxWidth,
            imageQuality: tImageDetails.quality,
          ),
        ).thenAnswer((_) async => null);

        pickImageDataSourceImpl =
            PickImageDataSourceImpl(picker: mockImagePicker);

        final result = await pickImageDataSourceImpl.getPickedImage(
          imageDetails: tImageDetails,
        );

        verify(
          () => mockImagePicker.pickImage(
            source: tImageDetails.imageSource,
            maxHeight: tImageDetails.maxHeight,
            maxWidth: tImageDetails.maxWidth,
            imageQuality: tImageDetails.quality,
          ),
        );

        expect(result, null);
      },
    );
  });
}
