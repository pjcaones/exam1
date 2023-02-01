import 'package:equatable/equatable.dart';
import 'package:exam1/core/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<Type, Params> {
  //A function required for every UseCase
  Future<Either<Failure, Type>> call(Params params);
}

//Self explanatory
//Use this class when you don't have to pass any param to a usecase
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
