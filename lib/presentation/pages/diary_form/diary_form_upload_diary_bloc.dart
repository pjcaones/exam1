part of 'diary_form_bloc.dart';

extension UploadDiaryBloc on AddPhotoBloc {
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

    final failureOrUploadedDiaryResult = await uploadDiary(diary);

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
