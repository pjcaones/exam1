import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockUploadDiaryRepository extends Mock implements DiaryRepository {}

void main() {
  late MockUploadDiaryRepository mockUploadDiaryRepository;
  late UploadDiary uploadDiary;

  setUp(() {
    mockUploadDiaryRepository = MockUploadDiaryRepository();
    uploadDiary = UploadDiary(mockUploadDiaryRepository);
  });

  const Diary tDiary = Diary(
    location: 'Sample location',
    imageList: [
      'test1.png',
      'test2.png',
      'test3.png',
    ],
    comment: 'Sample comment',
    diaryDateInMillis: 11111,
    areaID: 1,
    taskCategoryID: 1,
    tags: 'sample tag',
    eventID: 1,
  );

  const uploadDiaryResult = UploadedDiaryResult(id: '1');

  group('upload diary usecase', () {
    void stubUploadDiaryRepository(
        Either<Failure, UploadedDiaryResult> result) {
      when(
        () => mockUploadDiaryRepository.getResultFromUploadedDiary(
          diary: tDiary,
        ),
      ).thenAnswer((_) async => result);
    }

    test('should upload diary success', () async {
      stubUploadDiaryRepository(const Right(uploadDiaryResult));

      final result = await uploadDiary(tDiary);

      verify(
        () => mockUploadDiaryRepository.getResultFromUploadedDiary(
          diary: tDiary,
        ),
      );

      expect(result, const Right(uploadDiaryResult));
    });

    test('should upload diary fail', () async {
      stubUploadDiaryRepository(Left(ServerFailure()));

      final result = await uploadDiary(tDiary);

      verify(
        () => mockUploadDiaryRepository.getResultFromUploadedDiary(
          diary: tDiary,
        ),
      );

      expect(result, Left(ServerFailure()));
    });
  });
}
