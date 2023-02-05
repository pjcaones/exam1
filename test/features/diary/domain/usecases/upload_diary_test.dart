import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:exam1/features/diary/domain/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockUploadDiaryRepository extends Mock implements DiaryRepository {}

void main() {
  final mockUploadDiaryRepository = MockUploadDiaryRepository();
  const uploadDiaryResult = UploadedDiaryResult(id: '1');

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

  test('should upload diary', () async {
    when(
      () => mockUploadDiaryRepository.getResultFromUploadedDiary(
        diary: tDiary,
      ),
    ).thenAnswer((_) async => const Right(uploadDiaryResult));

    final result = await mockUploadDiaryRepository.getResultFromUploadedDiary(
      diary: tDiary,
    );

    verify(
      () => mockUploadDiaryRepository.getResultFromUploadedDiary(
        diary: tDiary,
      ),
    );

    expect(result, const Right(uploadDiaryResult));
  });

  test('should fail upload', () async {
    when(
      () => mockUploadDiaryRepository.getResultFromUploadedDiary(
        diary: tDiary,
      ),
    ).thenAnswer((_) async => Left(ServerFailure()));

    final result = await mockUploadDiaryRepository.getResultFromUploadedDiary(
      diary: tDiary,
    );

    verify(
      () => mockUploadDiaryRepository.getResultFromUploadedDiary(
        diary: tDiary,
      ),
    );

    expect(result, Left(ServerFailure()));
  });
}
