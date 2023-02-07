import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:exam1/di.dart' as get_it;

import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockPickImage extends Mock implements PickImage {}

class MockUploadDiary extends Mock implements UploadDiary {}

class MockAddPhotoBloc extends Mock implements DiaryBloc {}

void main() {
  late MockFileToBase64 mockFileToBase64;

  late PickImage mockPickImage;
  late MockUploadDiary mockUploadDiary;

  late DiaryBloc diaryBloc;

  get_it.init();

  setUp(() {
    mockFileToBase64 = MockFileToBase64();

    mockPickImage = MockPickImage();
    mockUploadDiary = MockUploadDiary();

    diaryBloc = DiaryBloc(
        fileToBase64: mockFileToBase64,
        pickImage: mockPickImage,
        uploadDiary: mockUploadDiary);
  });

  final XFile tImageFile = XFile('test1.png');
  final List<XFile> imageList = [];

  const ImageDetails tImageDetails = ImageDetails(
    imageSource: ImageSource.gallery,
  );

  test('diary form pick image success', () async {
    when(
      () => mockPickImage(tImageDetails),
    ).thenAnswer((_) async => Right(tImageFile));

    diaryBloc.add(PickImageEvent(imageList: imageList));
    await untilCalled(
      () => mockPickImage(tImageDetails),
    );

    await expectLater(
      diaryBloc.state,
      PickImageLoading(),
    );
    verify(() => mockPickImage(tImageDetails));

    imageList.add(tImageFile);
    expect(diaryBloc.state, PickImageSuccess(updatedImageList: imageList));
  });

  test('diary form pick image fail', () async {
    when(
      () => mockPickImage(tImageDetails),
    ).thenAnswer((_) async => Left(PickImageFailure()));

    diaryBloc.add(PickImageEvent(imageList: imageList));
    await untilCalled(
      () => mockPickImage(tImageDetails),
    );

    await expectLater(
      diaryBloc.state,
      PickImageLoading(),
    );
    verify(() => mockPickImage(tImageDetails));

    expect(diaryBloc.state, PickImageFailed());
  });
}
