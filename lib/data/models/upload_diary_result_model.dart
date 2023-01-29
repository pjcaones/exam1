import '../../domain/entities/uploaded_diary_result.dart';

class UploadedDiaryResultModel extends UploadedDiaryResult {
  const UploadedDiaryResultModel({
    required diaryID,
  }) : super(diaryID: diaryID);

  factory UploadedDiaryResultModel.fromJson(Map<String, dynamic> json) {
    return UploadedDiaryResultModel(
        diaryID: int.tryParse(json['id'].toString()) ?? 0);
  }
}
