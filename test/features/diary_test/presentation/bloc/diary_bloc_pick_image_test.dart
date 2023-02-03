import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/di.dart' as get_it;
import 'package:exam1/features/diary/domain/usecases/usecases.dart';
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

  test('diary form pick image bloc ...', () async {
    when(
      () => mockPickImage(ImageSource.gallery),
    ).thenAnswer((_) async => Right(tImageFile));

    diaryBloc.add(PickImageEvent(imageList: imageList));
    await untilCalled(
      () => mockPickImage(ImageSource.gallery),
    );

    await expectLater(
      diaryBloc.state,
      PickImageLoading(),
    );
    verify(() => mockPickImage(ImageSource.gallery));

    imageList.add(tImageFile);
    expect(diaryBloc.state, PickImageSuccess(updatedImageList: imageList));
  });
}