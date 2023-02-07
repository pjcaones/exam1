import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
      () => PickImage(
        pickImageRepository: serviceLocator(),
      ),
    )

    //Registering Repositories
    ..registerLazySingleton<DiaryRepository>(
      () => DiaryRepositoryImpl(
        diaryRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<PickImageRepository>(
      () => PickedImageRepositoryImpl(
        pickImageDataSource: serviceLocator(),
      ),
    )

    //Registering DataSources
    ..registerLazySingleton<DiaryRemoteDataSource>(
      () => DiaryRemoteDataSourceImpl(client: serviceLocator()),
    )
    ..registerLazySingleton<PickImageDataSource>(
      () => PickImageDataSourceImpl(picker: serviceLocator()),
    )

    //Core parts
    ..registerLazySingleton(
      FileToBase64.new,
    )

    //Registering external classes
    ..registerLazySingleton(
      http.Client.new,
    )
    ..registerLazySingleton(
      ImagePicker.new,
    );
}
