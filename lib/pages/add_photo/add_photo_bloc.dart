import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_photo_event.dart';
part 'add_photo_state.dart';

class AddPhotoBloc extends Bloc<AddPhotoEvent, AddPhotoState> {
  AddPhotoBloc() : super(AddPhotoInitial()) {
    on<UploadDiary>(_uploadDiary);
  }

  void _uploadDiary(UploadDiary event, Emitter<AddPhotoState> emit) async {
    try {
      // emit(UploadDiaryLoading());

      //Calling of api here..
    } catch (error) {
      log('_uploadDiary error: $error');
      emit(UploadDiaryFailed(
          errorMessage: 'Something went wrong while uploading your diary..'));
    }
  }
}
