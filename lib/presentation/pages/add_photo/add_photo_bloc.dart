import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/entities/entities.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

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
    emit(UploadDiaryLoading());

    List<File> fileList =
        event.imageList.map<File>((xfile) => File(xfile.path)).toList();
    List<String> fileListToBase64 =
        await fileToBase64.listConversion(fileList: fileList);

    final diary = Diary(
        location: event.location,
        imageList: fileListToBase64,
        comment: event.comment,
        diaryDateInMillis: event.diaryDate,
        areaID: event.areaID,
        taskCategoryID: event.taskCategoryID,
        tags: event.tags,
        eventID: event.eventID);

    final failureOrUploadedDiaryResult = await uploadDiary(params: diary);

    failureOrUploadedDiaryResult.fold(
      (failure) {
        log('_uploadDiary error: $failure');
        emit(UploadDiaryFailed(errorMessage: 'Failed to upload the diary.'));
        return;
      },
      (uploadedDiaryResult) {
        if (int.parse(uploadedDiaryResult.id) > 0) {
          emit(UploadDiarySuccess());
          return;
        } else {
          emit(UploadDiaryFailed(errorMessage: 'Failed to upload the diary.'));
        }
      },
    );
  }
}
