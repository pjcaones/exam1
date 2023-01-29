import 'dart:developer';
import 'dart:io';

import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/entities/uploaded_diary_result.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/diary.dart';

part 'add_photo_event.dart';
part 'add_photo_state.dart';

class AddPhotoBloc extends Bloc<AddPhotoEvent, AddPhotoState> {
  final FileToBase64 fileToBase64;
  final UploadDiary uploadDiary;

  AddPhotoBloc({
    required this.fileToBase64,
    required this.uploadDiary,
  }) : super(AddPhotoInitial()) {
    on<UploadDiaryEvent>(_uploadDiary);
  }

  void _uploadDiary(UploadDiaryEvent event, Emitter<AddPhotoState> emit) async {
    try {
      emit(UploadDiaryLoading());

      List<File> fileList =
          event.imageList.map<File>((xfile) => File(xfile.path)).toList();
      List<String> fileListToBase64 =
          await fileToBase64.listConversion(fileList: fileList);

      UploadedDiaryResult? uploadedDiaryResult = await uploadDiary(
          params: Diary(
              location: event.location,
              imageList: fileListToBase64,
              comment: event.comment,
              diaryDateInMillis: event.diaryDate,
              areaID: event.areaID,
              taskCategoryID: event.taskCategoryID,
              tags: event.tags,
              eventID: event.eventID));

      if (uploadedDiaryResult != null) {
        if (uploadedDiaryResult.diaryID > 0) {
          emit(UploadDiarySuccess());
          return;
        }
      }

      emit(UploadDiaryFailed());
    } catch (error) {
      log('_uploadDiary error: $error');
      emit(UploadDiaryFailed(
          errorMessage: 'Something went wrong while uploading your diary..'));
    }
  }
}
