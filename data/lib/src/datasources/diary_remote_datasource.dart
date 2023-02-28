import 'dart:convert';

import 'package:core/core.dart';
import 'package:data/src/models/models.dart';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;

abstract class DiaryRemoteDataSource {
  Future<UploadedDiaryResultModel> getResultFromUploadedDiary({
    required Diary diary,
  });
}

class DiaryRemoteDataSourceImpl implements DiaryRemoteDataSource {
  DiaryRemoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<UploadedDiaryResultModel> getResultFromUploadedDiary({
    required Diary diary,
  }) async {
    final url = Uri.parse('https://reqres.in/api/users/');
    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final diaryModel = DiaryModel(
      location: diary.location,
      imageList: diary.imageList,
      comment: diary.comment,
      diaryDateInMillis: diary.diaryDateInMillis,
      areaID: diary.areaID,
      taskCategoryID: diary.taskCategoryID,
      tags: diary.tags,
      eventID: diary.eventID,
    );

    final String body = jsonEncode(diaryModel.toJson());
    final response = await client.post(url, headers: header, body: body);

    if (response.statusCode == 201) {
      return UploadedDiaryResultModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
