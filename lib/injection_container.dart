import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/data/datasources/diary_remote_datasource.dart';
import 'package:exam1/data/repositories/diary_repository_impl.dart';
import 'package:exam1/domain/repositories/diary_repository.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:exam1/presentation/pages/add_photo/add_photo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

void init() {
  //Presentation parts

  //Registering Blocs
  serviceLocator.registerFactory(() => AddPhotoBloc(
        fileToBase64: serviceLocator(),
        uploadDiary: serviceLocator(),
      ));

  //Registering UseCases
  serviceLocator.registerLazySingleton(
    () => UploadDiary(
      serviceLocator(),
    ),
  );

  //Registering Repositories
  serviceLocator.registerLazySingleton<DiaryRepository>(
    () => DiaryRepositoryImpl(
      diaryRemoteDataSource: serviceLocator(),
    ),
  );

  //Registering DataSources
  serviceLocator.registerLazySingleton<DiaryRemoteDataSource>(
    () => DiaryRemoteDataSourceImpl(client: serviceLocator()),
  );

  //Core parts
  serviceLocator.registerLazySingleton(
    () => FileToBase64(),
  );

  //Registering external classes
  serviceLocator.registerLazySingleton(
    () => http.Client(),
  );
}
