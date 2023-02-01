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
  PickImageSuccess({required this.updatedImageList});
  final List<XFile> updatedImageList;
}

//For Image Removing
class RemoveImageLoading extends AddPhotoState {}

class RemoveImageSuccess extends AddPhotoState {
  RemoveImageSuccess({required this.updatedImageList});
  final List<XFile> updatedImageList;
}

class RemoveImageFailed extends AddPhotoState {}

//Uploading diary
class UploadDiaryLoading extends AddPhotoState {}

class UploadDiaryFailed extends AddPhotoState {
  UploadDiaryFailed({this.errorMessage});
  final String? errorMessage;
}

class UploadDiarySuccess extends AddPhotoState {}
