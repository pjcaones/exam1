import 'package:equatable/equatable.dart';

class UploadedDiaryResult extends Equatable {
  final int diaryID;

  const UploadedDiaryResult({required this.diaryID});

  @override
  List<Object?> get props => [diaryID];
}
