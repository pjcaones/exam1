import 'dart:convert';

import 'package:exam1/data/datasources/diary_remote_datasource.dart';
import 'package:exam1/data/models/diary_model.dart';
import 'package:exam1/data/models/uploaded_diary_result_model.dart';
import 'package:exam1/data/repositories/diary_repository_impl.dart';
import 'package:exam1/domain/entities/diary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:http/http.dart' as http;

class MockUploadDiaryRemoteDataSource extends Mock
    implements DiaryRemoteDataSource {}

class MockHttpClient extends Mock implements http.Client {
  @override
  Future<http.Response> post(Uri url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      super.noSuchMethod(Invocation.getter(#uri));
}

void main() {
  late DiaryRepositoryImpl repositoryImpl;
  late MockUploadDiaryRemoteDataSource mockUploadDiaryRemoteDataSource;

  late MockHttpClient mockHttpClient;
  late DiaryRemoteDataSourceImpl dataSourceImpl;

  final url = Uri.parse('https://reqres.in/api/users/');

  setUp(() {
    mockUploadDiaryRemoteDataSource = MockUploadDiaryRemoteDataSource();
    repositoryImpl = DiaryRepositoryImpl(
        diaryRemoteDataSource: mockUploadDiaryRemoteDataSource);

    mockHttpClient = MockHttpClient();
    dataSourceImpl = DiaryRemoteDataSourceImpl(client: mockHttpClient);

    registerFallbackValue(url);
  });

  Diary tDiary = Diary(
      location: 'Sample location',
      imageList: const [
        'QWERTYUIOP',
        'ASDFGHJKL',
        'ZXCVBNM'
      ], //Sample converted base64 image
      comment: 'Sample Comment',
      diaryDateInMillis: DateTime.now().millisecondsSinceEpoch,
      areaID: 1,
      taskCategoryID: 1,
      tags: 'Sample tag',
      eventID: 1);

  DiaryModel tDiaryModel = DiaryModel(
      location: 'Sample location',
      imageList: const [
        'QWERTYUIOP',
        'ASDFGHJKL',
        'ZXCVBNM'
      ], //Sample converted base64 image
      comment: 'Sample Comment',
      diaryDateInMillis: DateTime.now().millisecondsSinceEpoch,
      areaID: 1,
      taskCategoryID: 1,
      tags: 'Sample tag',
      eventID: 1);

  const tUploadedDiaryResultModel = UploadedDiaryResultModel(id: '1');

  test('should return the remote data source after it was called', () async {
    when(
      () => mockUploadDiaryRemoteDataSource.getResultFromUploadedDiary(
        diary: tDiary,
      ),
    ).thenAnswer((_) async => tUploadedDiaryResultModel);

    final result =
        await repositoryImpl.getResultFromUploadedDiary(diary: tDiary);

    verify(() => mockUploadDiaryRemoteDataSource.getResultFromUploadedDiary(
        diary: tDiary));
    expect(result, const Right(tUploadedDiaryResultModel));
  });

  group('actual uploading of data', () {
    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    String uploadedBody = jsonEncode(tDiaryModel.toJson());
    String resultResponseBody = jsonEncode(tUploadedDiaryResultModel.toJson());

    test('should perform uploading of data', () async {
      //Response 201 is response from reqres.in api
      when(() => mockHttpClient.post(url, headers: header, body: uploadedBody))
          .thenAnswer((_) async => http.Response(resultResponseBody, 201));

      final result =
          await dataSourceImpl.getResultFromUploadedDiary(diary: tDiary);
      verify(
          () => mockHttpClient.post(url, headers: header, body: uploadedBody));

      expect(result, tUploadedDiaryResultModel);
    });
  });
}
