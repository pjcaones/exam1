part of 'diary_form_bloc.dart';

@immutable
abstract class AddPhotoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddPhotoInitial extends AddPhotoState {}

//For Image Picking
class PickImageLoading extends AddPhotoState {}

class PickImageFailed extends AddPhotoState {}

class PickImageSuccess extends AddPhotoState {
  final List<XFile> updatedImageList;

  PickImageSuccess({required this.updatedImageList});
}

//For Image Removing
class RemoveImageLoading extends AddPhotoState {}

class RemoveImageSuccess extends AddPhotoState {
  final List<XFile> updatedImageList;

  RemoveImageSuccess({required this.updatedImageList});
}

class RemoveImageFailed extends AddPhotoState {}

//Uploading diary
class UploadDiaryLoading extends AddPhotoState {}

class UploadDiaryFailed extends AddPhotoState {
  final String? errorMessage;

  UploadDiaryFailed({this.errorMessage});
}

class UploadDiarySuccess extends AddPhotoState {}
