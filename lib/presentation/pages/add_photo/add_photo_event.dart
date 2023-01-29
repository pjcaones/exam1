part of 'add_photo_bloc.dart';

@immutable
abstract class AddPhotoEvent {}

class UploadDiaryEvent extends AddPhotoEvent {
  final String location;
  final List<XFile> imageList;
  final String comment;
  final int diaryDate;
  final int areaID;
  final int taskCategoryID;
  final String tags;
  final int eventID;

  UploadDiaryEvent(
      {required this.location,
      required this.imageList,
      required this.comment,
      required this.diaryDate,
      required this.areaID,
      required this.taskCategoryID,
      required this.tags,
      required this.eventID});
}
