import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/di.dart' as get_it;
import 'package:exam1/features/diary/domain/usecases/usecases.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImageHelper extends Mock implements ImageHelper {}

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockPickImage extends Mock implements PickImage {}

class MockUploadDiary extends Mock implements UploadDiary {}

void main() {
  late MockFileToBase64 mockFileToBase64;

  late MockPickImage mockPickImage;
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

  const int indexToRemove = 1;
  final List<XFile> imageList = [
    XFile('test1.png'),
    XFile('test2.png'),
    XFile('test3.png'),
  ];

  testWidgets('diary form remove image bloc ...', (tester) async {
    //Need further test
    diaryBloc.add(
      RemoveImageEvent(
        index: indexToRemove,
        imageList: imageList,
      ),
    );

    await expectLater(
      diaryBloc.state,
      DiaryInitial(),
    );

    imageList.removeAt(indexToRemove);
    expect(diaryBloc.state, RemoveImageSuccess(updatedImageList: imageList));
  });
}
