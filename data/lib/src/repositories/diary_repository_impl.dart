import 'package:core/core.dart';
import 'package:data/src/datasources/datasources.dart';
import 'package:domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  DiaryRepositoryImpl({required this.diaryRemoteDataSource});
  final DiaryRemoteDataSource diaryRemoteDataSource;

  @override
  Future<Either<Failure, UploadedDiaryResult>> getResultFromUploadedDiary({
    required Diary diary,
  }) async {
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
