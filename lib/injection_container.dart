import 'package:exam1/core/helpers/image_helper.dart';
import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/data/datasources/diary_remote_datasource.dart';
import 'package:exam1/data/repositories/diary_repository_impl.dart';
import 'package:exam1/domain/repositories/diary_repository.dart';
import 'package:exam1/domain/usecases/usecases.dart';
import 'package:exam1/presentation/pages/diary_form/diary_form.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

void init() {
  //Presentation parts

  //Registering Blocs
  serviceLocator.registerFactory(() => AddPhotoBloc(
        pickImage: serviceLocator(),
        fileToBase64: serviceLocator(),
        uploadDiary: serviceLocator(),
      ));

  //Registering UseCases
  serviceLocator.registerLazySingleton(
    () => UploadDiary(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => PickImage(imageHelper: serviceLocator()),
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

  serviceLocator.registerLazySingleton(
    () => ImageHelper(),
  );

  //Registering external classes
  serviceLocator.registerLazySingleton(
    () => http.Client(),
  );
}
