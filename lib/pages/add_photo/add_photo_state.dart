part of 'add_photo_bloc.dart';

@immutable
abstract class AddPhotoState {}

class AddPhotoInitial extends AddPhotoState {}

class UploadDiaryLoading extends AddPhotoState {}

class UploadDiaryFailed extends AddPhotoState {
  final String? errorMessage;

  UploadDiaryFailed({this.errorMessage});
}

class UploadDiarySuccess extends AddPhotoState {}
