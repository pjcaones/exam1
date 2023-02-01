import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/domain/usecases/usecases.dart';
import 'package:exam1/presentation/pages/diary_form/diary_form_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:exam1/injection_container.dart' as get_it;

class MockImageHelper extends Mock implements ImageHelper {}

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockPickImage extends Mock implements PickImage {}

class MockUploadDiary extends Mock implements UploadDiary {}

void main() {
  late MockImageHelper mockImageHelper;
  late MockFileToBase64 mockFileToBase64;

  late MockPickImage mockPickImage;
  late MockUploadDiary mockUploadDiary;

  late AddPhotoBloc addPhotoBloc;

  get_it.init();

  setUp(() {
    mockImageHelper = MockImageHelper();
    mockFileToBase64 = MockFileToBase64();

    mockPickImage = MockPickImage();
    mockUploadDiary = MockUploadDiary();

    addPhotoBloc = AddPhotoBloc(
        fileToBase64: mockFileToBase64,
        pickImage: mockPickImage,
        uploadDiary: mockUploadDiary);
  });

  XFile tImageFile = XFile('test1.png');
  List<XFile> imageList = [];

  testWidgets('diary form pick image bloc ...', (tester) async {
    //Need further test
    when(
      () => mockImageHelper.pickImage(source: ImageSource.gallery),
    ).thenAnswer((_) async => tImageFile);

    addPhotoBloc.add(PickImageEvent(imageList: imageList));

    await untilCalled(
      () => mockImageHelper.pickImage(source: ImageSource.gallery),
    );
    verify(() => mockImageHelper.pickImage(source: ImageSource.gallery));

    //Playing with states here..
  });
}
