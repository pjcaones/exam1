import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/domain/usecases/usecases.dart';
import 'package:exam1/injection_container.dart' as get_it;
import 'package:exam1/presentation/pages/diary_form/diary_form.dart';
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

  late AddPhotoBloc addPhotoBloc;

  get_it.init();

  setUp(() {
    mockFileToBase64 = MockFileToBase64();

    mockPickImage = MockPickImage();
    mockUploadDiary = MockUploadDiary();

    addPhotoBloc = AddPhotoBloc(
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
    addPhotoBloc.add(
      RemoveImageEvent(
        index: indexToRemove,
        imageList: imageList,
      ),
    );

    //Playing of states here..
  });
}
