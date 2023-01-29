abstract class UseCase<Type, Params> {
  //A function required for every UseCase
  Future<Type?> call({Params params});
}
