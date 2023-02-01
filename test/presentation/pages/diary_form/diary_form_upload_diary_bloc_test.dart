import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/entities/diary.dart';
import 'package:exam1/domain/entities/uploaded_diary_result.dart';
import 'package:exam1/domain/usecases/pick_image.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:exam1/presentation/pages/diary_form/diary_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockPickImage extends Mock implements PickImage {}

class MockUploadDiary extends Mock implements UploadDiary {
  @override
  Future<Either<Failure, UploadedDiaryResult>> call(Diary params) =>
      super.noSuchMethod(Invocation.getter(#params));
}

class FakeDiary extends Fake implements Diary {}

void main() {
  late AddPhotoBloc addPhotoBloc;
  late MockFileToBase64 mockFileToBase64;
  late MockPickImage mockPickImage;
  late MockUploadDiary mockUploadDiary;

  setUp(() {
    mockFileToBase64 = MockFileToBase64();
    mockPickImage = MockPickImage();
    mockUploadDiary = MockUploadDiary();

    addPhotoBloc = AddPhotoBloc(
      fileToBase64: mockFileToBase64,
      pickImage: mockPickImage,
      uploadDiary: mockUploadDiary,
    );
  });

  //Sample converted base64 from sample selected images
  final List<String> tConvertedFileList = ['Test 1', 'Test 2', 'Test 3'];

  //Sample data to be uploaded
  const String location = 'location';
  const String comment = 'comment';
  final int diaryDateInMillis = DateTime.now().millisecondsSinceEpoch;
  const int areaID = 1;
  const int taskCategoryID = 1;
  const String tags = 'Sample Tag';
  const int eventID = 1;

  final tDiary = Diary(
    location: location,
    imageList: tConvertedFileList,
    comment: comment,
    diaryDateInMillis: diaryDateInMillis,
    areaID: areaID,
    taskCategoryID: taskCategoryID,
    tags: tags,
    eventID: eventID,
  );

  const tUploadedDiaryResult = UploadedDiaryResult(id: '1');

  group('For pressing the next button', () {
    registerFallbackValue(FakeDiary());

    void stubBase64List() {
      when(
        () => mockFileToBase64.listConversion(fileList: any(named: 'fileList')),
      ).thenAnswer((_) async => tConvertedFileList);
    }

    void stubDiaryResult() {
      when(
        () => mockUploadDiary(tDiary),
      ).thenAnswer((_) async => const Right(tUploadedDiaryResult));
    }

    test('should call the upload diary usecase first for checking', () async {
      stubDiaryResult();
      final mockResult = await mockUploadDiary(tDiary);
      verify(() => mockUploadDiary(tDiary));

      expect(mockResult, const Right(tUploadedDiaryResult));
    });

    test('should get the from use case function', () async {
      stubBase64List();
      stubDiaryResult();

      expect(addPhotoBloc, isA<AddPhotoBloc>());
      expect(tDiary, isA<Diary>());

      addPhotoBloc.add(UploadDiaryEvent(
          location: location,
          imageList: [
            XFile('Test1.png'),
            XFile('Test2.png'),
            XFile('Test3.png'),
          ],
          comment: comment,
          diaryDate: diaryDateInMillis,
          areaID: areaID,
          taskCategoryID: taskCategoryID,
          tags: tags,
          eventID: eventID));

      await untilCalled(
        () => mockUploadDiary(tDiary),
      );
      verify(() => mockUploadDiary(tDiary));
    });

    test('should emit states from loading to success', () async* {
      stubDiaryResult();

      //expected emits
      final expectedEmits = [
        AddPhotoInitial(),
        UploadDiaryLoading(),
        UploadDiarySuccess(),
      ];

      await expectLater(addPhotoBloc, emitsInOrder(expectedEmits));
      addPhotoBloc.add(UploadDiaryEvent(
          location: location,
          imageList: [
            XFile('Test1.png'),
            XFile('Test2.png'),
            XFile('Test3.png')
          ],
          comment: comment,
          diaryDate: diaryDateInMillis,
          areaID: areaID,
          taskCategoryID: taskCategoryID,
          tags: tags,
          eventID: eventID));
    });
  });
}
