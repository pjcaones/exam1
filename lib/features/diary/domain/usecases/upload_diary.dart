import 'package:exam1/core/errors/errors.dart';
import 'package:exam1/core/usecases/usecases.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:exam1/features/diary/domain/repositories/repositories.dart';
import 'package:fpdart/fpdart.dart';

class UploadDiary implements UseCase<UploadedDiaryResult, Diary> {
  UploadDiary(this.diaryRepository);
  final DiaryRepository diaryRepository;

  @override
  Future<Either<Failure, UploadedDiaryResult>> call(Diary params) async {
    return diaryRepository.getResultFromUploadedDiary(diary: params);
  }
}
