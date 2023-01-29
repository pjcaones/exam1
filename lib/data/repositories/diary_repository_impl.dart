import '../../domain/entities/uploaded_diary_result.dart';
import '../../domain/entities/diary.dart';
import '../../domain/repositories/diary_repository.dart';
import '../datasources/diary_remote_datasource.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryRemoteDataSource diaryRemoteDataSource;

  DiaryRepositoryImpl({required this.diaryRemoteDataSource});

  @override
  Future<UploadedDiaryResult> getResultFromUploadedDiary(Diary diary) async {
    return await diaryRemoteDataSource.getResultFromUploadedDiary(diary: diary);
  }
}
