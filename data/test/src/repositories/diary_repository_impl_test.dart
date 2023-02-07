import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockUploadDiaryDataSource extends Mock implements DiaryRemoteDataSource {}

void main() {
  late MockUploadDiaryDataSource mockUploadDiaryDataSource;
  late DiaryRepositoryImpl diaryRepositoryImpl;

  setUp(() {
    mockUploadDiaryDataSource = MockUploadDiaryDataSource();
    diaryRepositoryImpl =
        DiaryRepositoryImpl(diaryRemoteDataSource: mockUploadDiaryDataSource);
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

  const uploadDiaryResult = UploadedDiaryResultModel(id: '1');

  group('upload diary repository impl', () {
    test('should success', () async {
      when(
        () => mockUploadDiaryDataSource.getResultFromUploadedDiary(
          diary: tDiary,
        ),
      ).thenAnswer((_) async => uploadDiaryResult);

      final result = await diaryRepositoryImpl.getResultFromUploadedDiary(
        diary: tDiary,
      );

      expect(result, const Right(uploadDiaryResult));
    });

    test('should fail', () async {
      when(
        () => mockUploadDiaryDataSource.getResultFromUploadedDiary(
          diary: tDiary,
        ),
      ).thenAnswer((_) async => throw ServerException());

      final result = await diaryRepositoryImpl.getResultFromUploadedDiary(
        diary: tDiary,
      );

      expect(result, Left(ServerFailure()));
    });
  });
}
