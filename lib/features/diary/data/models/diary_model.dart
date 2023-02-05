import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_model.freezed.dart';
part 'diary_model.g.dart';

@Freezed()
class DiaryModel extends Diary with _$DiaryModel {
  const factory DiaryModel({
    required String location,
    required List<String> imageList,
    required String comment,
    required int diaryDateInMillis,
    required int areaID,
    required int taskCategoryID,
    required String tags,
    required int eventID,
  }) = _DiaryModel;
}
