part of 'diary_bloc.dart';

abstract class DiaryState extends Equatable {
  const DiaryState();

  @override
  List<Object?> get props => [];
}

class DiaryInitial extends DiaryState {}

//For Image Picking
class PickImageLoading extends DiaryState {}

class PickImageFailed extends DiaryState {}

class PickImageSuccess extends DiaryState {
  const PickImageSuccess({required this.updatedImageList});
  final List<XFile> updatedImageList;

  @override
  List<Object> get props => [updatedImageList];
}

//For Image Removing
class RemoveImageLoading extends DiaryState {}

class RemoveImageSuccess extends DiaryState {
  const RemoveImageSuccess({required this.updatedImageList});
  final List<XFile> updatedImageList;

  @override
  List<Object> get props => [updatedImageList];
}

class RemoveImageFailed extends DiaryState {}

//Uploading diary
class UploadDiaryLoading extends DiaryState {}

class UploadDiaryFailed extends DiaryState {
  const UploadDiaryFailed({this.errorMessage});
  final String? errorMessage;
}

class UploadDiarySuccess extends DiaryState {}
