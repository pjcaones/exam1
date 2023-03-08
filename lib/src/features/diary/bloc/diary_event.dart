part of 'diary_bloc.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object> get props => [];
}

class DiaryInitialEvent extends DiaryEvent {}

class PickImageEvent extends DiaryEvent {
  const PickImageEvent({
    required this.imageList,
    this.imageSource = ImageSource.gallery,
  });
  final List<XFile> imageList;
  final ImageSource imageSource;

  @override
  List<Object> get props => [
        imageList,
        imageSource,
      ];
}

class RemoveImageEvent extends DiaryEvent {
  const RemoveImageEvent({
    required this.index,
    required this.imageList,
  });
  final int index;
  final List<XFile> imageList;

  @override
  List<Object> get props => [
        index,
        imageList,
      ];
}

class UploadDiaryEvent extends DiaryEvent {
  const UploadDiaryEvent({
    required this.location,
    required this.imageList,
    required this.comment,
    required this.diaryDate,
    required this.areaID,
    required this.taskCategoryID,
    required this.tags,
    required this.eventID,
  });
  final String location;
  final List<XFile> imageList;
  final String comment;
  final int diaryDate;
  final int areaID;
  final int taskCategoryID;
  final String tags;
  final int eventID;

  @override
  List<Object> get props => [
        location,
        imageList,
        comment,
        diaryDate,
        areaID,
        taskCategoryID,
        tags,
        eventID,
      ];
}
