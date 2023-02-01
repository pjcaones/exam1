import 'package:exam1/core/errors/errors.dart';
import 'package:exam1/data/datasources/datasources.dart';
import 'package:exam1/domain/entities/entities.dart';
import 'package:exam1/domain/repositories/repositories.dart';
import 'package:fpdart/fpdart.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  DiaryRepositoryImpl({required this.diaryRemoteDataSource});
  final DiaryRemoteDataSource diaryRemoteDataSource;

  @override
  Future<Either<Failure, UploadedDiaryResult>> getResultFromUploadedDiary(
      {required Diary diary}) async {
    try {
      final uploadDiaryResult =
          await diaryRemoteDataSource.getResultFromUploadedDiary(
        diary: diary,
      );

      return Right(uploadDiaryResult);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
