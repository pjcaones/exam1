import 'package:exam1/data/models/upload_diary_result_model.dart';
import 'package:exam1/domain/entities/diary.dart';
import 'package:exam1/domain/entities/uploaded_diary_result.dart';
import 'package:exam1/domain/repositories/diary_repository.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDiaryRepository extends Mock implements DiaryRepository {}

void main() {
  late UploadDiary usecase;
  late MockDiaryRepository mockDiaryRepository;

  setUp(() {
    mockDiaryRepository = MockDiaryRepository();
    usecase = UploadDiary(mockDiaryRepository);
  });

  //Test if the value was passed from entity to usecase
  UploadedDiaryResult tUploadedDiaryResult =
      const UploadedDiaryResult(diaryID: 1);
  Diary tDiary = Diary(
      location: 'Sample location',
      imageList: const [
        'QWERTYUIOP',
        'ASDFGHJKL',
        'ZXCVBNM'
      ], //Sample converted base64 image
      comment: 'Sample Comment',
      diaryDateInMillis: DateTime.now().millisecondsSinceEpoch,
      areaID: 1,
      taskCategoryID: 1,
      tags: 'Sample tag',
      eventID: 1);

  test('Get the diary data from repository', () async {
    //when -> set the result of this repository to tDiaryID
    when(() => mockDiaryRepository.getResultFromUploadedDiary(tDiary))
        .thenAnswer((_) async => tUploadedDiaryResult);

    //calling the function of usecase for which the result should be tDiaryID
    final result = await usecase(params: tDiary);

    //expect -> expecting that the actual result is same with tDiaryID
    expect(result, tUploadedDiaryResult);

    //verifying if the repository was called
    verify(() => mockDiaryRepository.getResultFromUploadedDiary(tDiary));
    verifyNoMoreInteractions(mockDiaryRepository);
  });

  test('Getting the result after uploading', () async {
    const tUploadedDiaryModel = UploadedDiaryResultModel(diaryID: 1);
    final expectedMap = {
      "id": "267",
      "createdAt": "2023-01-28T01:59:43.808Z",
    };

    expect(tUploadedDiaryModel, isA<UploadedDiaryResult>());

    final result = UploadedDiaryResultModel.fromJson(expectedMap);

    expect(result.diaryID, 267);
  });
}
