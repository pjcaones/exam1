import 'package:core/core.dart';
import 'package:domain/src/entities/entities.dart';
import 'package:fpdart/fpdart.dart';

abstract class DiaryRepository {
  Future<Either<Failure, UploadedDiaryResult>> getResultFromUploadedDiary({
    required Diary diary,
  });
}
