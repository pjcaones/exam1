import '../entities/diary.dart';
import '../entities/uploaded_diary_result.dart';

abstract class DiaryRepository {
  Future<UploadedDiaryResult> getResultFromUploadedDiary(Diary diary);
}
