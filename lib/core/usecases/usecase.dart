import 'package:exam1/core/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<Type, Params> {
  //A function required for every UseCase
  Future<Either<Failure, Type>> call({required Params params});
}
