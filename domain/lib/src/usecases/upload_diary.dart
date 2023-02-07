import 'package:core/core.dart';
import 'package:domain/src/entities/entities.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/repositories.dart';

class UploadDiary implements UseCase<UploadedDiaryResult, Diary> {
  UploadDiary(this.diaryRepository);
  final DiaryRepository diaryRepository;

  @override
  Future<Either<Failure, UploadedDiaryResult>> call(Diary params) async {
    return diaryRepository.getResultFromUploadedDiary(diary: params);
  }
}
