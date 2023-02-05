import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'uploaded_diary_result_model.freezed.dart';
part 'uploaded_diary_result_model.g.dart';

@Freezed()
class UploadedDiaryResultModel extends UploadedDiaryResult
    with _$UploadedDiaryResultModel {
  const factory UploadedDiaryResultModel({
    required String id,
  }) = _UploadedDiaryResultModel;

  factory UploadedDiaryResultModel.fromJson(Map<String, dynamic> json) =>
      _$UploadedDiaryResultModelFromJson(json);
}
