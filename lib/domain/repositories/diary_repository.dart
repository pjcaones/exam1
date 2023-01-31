import 'package:exam1/core/errors/errors.dart';
import 'package:exam1/domain/entities/entities.dart';
import 'package:fpdart/fpdart.dart';

abstract class DiaryRepository {
  Future<Either<Failure, UploadedDiaryResult>> getResultFromUploadedDiary({
    required Diary diary,
  });
}
