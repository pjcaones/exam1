import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:exam1/src/features/diary/diary.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

final serviceLocator = GetIt.instance;

void init() {
  registerPresentationInstances();
  registerDomainInstances();
  registerDataInstances();
  registerCoreInstances();
  registerThirdPartyInstances();
}

void registerPresentationInstances() {
  serviceLocator.registerFactory(() => DiaryBloc(
        pickImage: serviceLocator(),
        fileToBase64: serviceLocator(),
        uploadDiary: serviceLocator(),
      ));
}

void registerDomainInstances() {
  //Use cases
  serviceLocator
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

    //Repositories
    ..registerLazySingleton<DiaryRepository>(
      () => DiaryRepositoryImpl(
        diaryRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton<PickImageRepository>(
      () => PickImageRepositoryImpl(
        pickImageDataSource: serviceLocator(),
      ),
    );
}

void registerDataInstances() {
  serviceLocator
    ..registerLazySingleton<DiaryRemoteDataSource>(
      () => DiaryRemoteDataSourceImpl(client: serviceLocator()),
    )
    ..registerLazySingleton<PickImageDataSource>(
      () => PickImageDataSourceImpl(picker: serviceLocator()),
    );
}

void registerCoreInstances() {
  serviceLocator.registerLazySingleton(
    FileToBase64.new,
  );
}

void registerThirdPartyInstances() {
  serviceLocator
    ..registerLazySingleton(
      http.Client.new,
    )
    ..registerLazySingleton(
      ImagePicker.new,
    );
}
