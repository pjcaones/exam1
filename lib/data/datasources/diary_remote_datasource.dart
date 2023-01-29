import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/diary.dart';
import '../models/diary_model.dart';
import '../models/upload_diary_result_model.dart';

abstract class DiaryRemoteDataSource {
  Future<UploadedDiaryResultModel> getResultFromUploadedDiary({Diary? diary});
}

class DiaryRemoteDataSourceImpl implements DiaryRemoteDataSource {
  final http.Client client;

  DiaryRemoteDataSourceImpl({required this.client});

  @override
  Future<UploadedDiaryResultModel> getResultFromUploadedDiary(
      {Diary? diary}) async {
    final url = Uri.parse('https://reqres.in/api/users/');
    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final DiaryModel diaryModel = DiaryModel(
        location: diary?.location ?? '',
        imageList: diary?.imageList ?? [],
        comment: diary?.comment ?? '',
        diaryDateInMillis: diary?.diaryDateInMillis ?? 0,
        areaID: diary?.areaID ?? 0,
        taskCategoryID: diary?.taskCategoryID ?? 0,
        tags: diary?.tags ?? '',
        eventID: diary?.eventID ?? 0);

    String body = jsonEncode(diaryModel.toJson());
    final response = await client.post(url, headers: header, body: body);

    if (response.statusCode == 201) {
      return UploadedDiaryResultModel.fromJson(json.decode(response.body));
    }

    return const UploadedDiaryResultModel(diaryID: 0);
  }
}
