import '../../core/usecases/usecase.dart';
import '../entities/diary.dart';
import '../entities/uploaded_diary_result.dart';
import '../repositories/diary_repository.dart';

class UploadDiary implements UseCase<UploadedDiaryResult, Diary> {
  final DiaryRepository diaryRepository;

  UploadDiary(this.diaryRepository);

  @override
  Future<UploadedDiaryResult?> call({Diary? params}) async {
    if (params != null) {
      return await diaryRepository.getResultFromUploadedDiary(params);
    }

    return null;
  }
}
