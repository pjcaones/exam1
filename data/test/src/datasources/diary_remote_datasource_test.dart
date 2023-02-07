import 'dart:convert';

import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

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

  final Diary tDiary = Diary(
      location: 'Sample location',
      imageList: const [
        'test1',
        'test2',
        'test3'
      ], //Sample converted base64 image
      comment: 'Sample Comment',
      diaryDateInMillis: DateTime.now().millisecondsSinceEpoch,
      areaID: 1,
      taskCategoryID: 1,
      tags: 'Sample tag',
      eventID: 1);

  final DiaryModel tDiaryModel = DiaryModel(
      location: 'Sample location',
      imageList: const [
        'test1',
        'test2',
        'test3'
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

    final String uploadedBody = jsonEncode(tDiaryModel.toJson());
    final String resultResponseBody =
        jsonEncode(tUploadedDiaryResultModel.toJson());

    test('should perform success uploading of data', () async {
      //Response 201 is response from reqres.in api
      when(() => mockHttpClient.post(url, headers: header, body: uploadedBody))
          .thenAnswer((_) async => http.Response(resultResponseBody, 201));

      final result =
          await dataSourceImpl.getResultFromUploadedDiary(diary: tDiary);
      verify(
          () => mockHttpClient.post(url, headers: header, body: uploadedBody));

      expect(result, tUploadedDiaryResultModel);
    });

    test('should perform failed uploading of data', () async {
      //Response 413 is an example of failed response
      when(() => mockHttpClient.post(url, headers: header, body: uploadedBody))
          .thenAnswer((_) async => http.Response(resultResponseBody, 413));

      final methodCall = dataSourceImpl.getResultFromUploadedDiary;

      expect(
        methodCall(diary: tDiary),
        throwsA(
          const TypeMatcher<ServerException>(),
        ),
      );
    });
  });
}
