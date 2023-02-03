import 'package:exam1/core/helpers/helpers.dart';
import 'package:exam1/features/diary/data/datasources/datasources.dart';
import 'package:exam1/features/diary/data/repositories/repositories.dart';
import 'package:exam1/features/diary/domain/repositories/repositories.dart';
import 'package:exam1/features/diary/domain/usecases/usecases.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

void init() {
  //Presentation parts

  //Registering Blocs
  serviceLocator
    ..registerFactory(() => DiaryBloc(
          pickImage: serviceLocator(),
          fileToBase64: serviceLocator(),
          uploadDiary: serviceLocator(),
        ))

    //Registering UseCases
    ..registerLazySingleton(
      () => UploadDiary(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => PickImage(imageHelper: serviceLocator()),
    )

    //Registering Repositories
    ..registerLazySingleton<DiaryRepository>(
      () => DiaryRepositoryImpl(
        diaryRemoteDataSource: serviceLocator(),
      ),
    )

    //Registering DataSources
    ..registerLazySingleton<DiaryRemoteDataSource>(
      () => DiaryRemoteDataSourceImpl(client: serviceLocator()),
    )

    //Core parts
    ..registerLazySingleton(
      FileToBase64.new,
    )
    ..registerLazySingleton(
      ImageHelper.new,
    )

    //Registering external classes
    ..registerLazySingleton(
      http.Client.new,
    );
}
