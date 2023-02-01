part of 'diary_form_bloc.dart';

@immutable
abstract class AddPhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageEvent extends AddPhotoEvent {
  PickImageEvent({
    required this.imageList,
    this.imageSource = ImageSource.gallery,
  });
  final List<XFile> imageList;
  final ImageSource imageSource;
}

class RemoveImageEvent extends AddPhotoEvent {
  RemoveImageEvent({
    required this.index,
    required this.imageList,
  });
  final int index;
  final List<XFile> imageList;
}

class UploadDiaryEvent extends AddPhotoEvent {
  UploadDiaryEvent(
      {required this.location,
      required this.imageList,
      required this.comment,
      required this.diaryDate,
      required this.areaID,
      required this.taskCategoryID,
      required this.tags,
      required this.eventID});
  final String location;
  final List<XFile> imageList;
  final String comment;
  final int diaryDate;
  final int areaID;
  final int taskCategoryID;
  final String tags;
  final int eventID;
}
