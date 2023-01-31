import 'package:exam1/core/errors/errors.dart';
import 'package:exam1/core/usecases/usecases.dart';
import 'package:exam1/domain/entities/entities.dart';
import 'package:exam1/domain/repositories/repositories.dart';
import 'package:fpdart/fpdart.dart';

class UploadDiary implements UseCase<UploadedDiaryResult, Diary> {
  final DiaryRepository diaryRepository;

  UploadDiary(this.diaryRepository);

  @override
  Future<Either<Failure, UploadedDiaryResult>> call(
      {required Diary params}) async {
    return await diaryRepository.getResultFromUploadedDiary(diary: params);
  }
}
