import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:exam1/src/features/diary/diary.dart';
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
  late DiaryBloc diaryBloc;
  late MockFileToBase64 mockFileToBase64;
  late MockPickImage mockPickImage;
  late MockUploadDiary mockUploadDiary;

  setUp(() {
    mockFileToBase64 = MockFileToBase64();
    mockPickImage = MockPickImage();
    mockUploadDiary = MockUploadDiary();

    diaryBloc = DiaryBloc(
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

  final uploadDiaryEvent = UploadDiaryEvent(
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

    void stubDiaryResult(Either<Failure, UploadedDiaryResult> result) {
      when(
        () => mockUploadDiary(tDiary),
      ).thenAnswer((_) async => result);
    }

    test('should success the upload diary', () async {
      stubBase64List();
      stubDiaryResult(const Right(tUploadedDiaryResult));

      diaryBloc.add(uploadDiaryEvent);

      await expectLater(
        diaryBloc.stream,
        emitsInOrder([
          UploadDiaryLoading(),
          UploadDiarySuccess(),
        ]),
      );

      verify(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          ));

      verify(() => mockUploadDiary(tDiary));
    });

    test('should fail the upload diary', () async {
      stubBase64List();
      stubDiaryResult(Left(PickImageFailure()));

      diaryBloc.add(uploadDiaryEvent);

      await expectLater(
        diaryBloc.stream,
        emitsInOrder([
          UploadDiaryLoading(),
          const UploadDiaryFailed(),
        ]),
      );

      verify(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          ));

      verify(() => mockUploadDiary(tDiary));
    });

    test('should fail the upload diary when id = 0', () async {
      stubBase64List();
      stubDiaryResult(const Right(UploadedDiaryResult(id: '0')));

      diaryBloc.add(uploadDiaryEvent);

      await expectLater(
        diaryBloc.stream,
        emitsInOrder([
          UploadDiaryLoading(),
          const UploadDiaryFailed(),
        ]),
      );

      verify(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          ));

      verify(() => mockUploadDiary(tDiary));
    });
  });
}
