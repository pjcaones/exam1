import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc({
    required this.fileToBase64,
    required this.pickImage,
    required this.uploadDiary,
  }) : super(DiaryInitial()) {
    on<UploadDiaryEvent>(_uploadDiary);
    on<PickImageEvent>(_pickImage);
    on<RemoveImageEvent>(_removeImage);
  }
  final FileToBase64 fileToBase64;
  final PickImage pickImage;
  final UploadDiary uploadDiary;

  Future<void> _pickImage(
      PickImageEvent event, Emitter<DiaryState> emit) async {
    emit(PickImageLoading());

    final List<XFile> imageList = event.imageList;
    final failOrImage = await pickImage(
      const ImageDetails(
        imageSource: ImageSource.gallery,
      ),
    );

    failOrImage.fold((fail) {
      emit(PickImageFailed());
    }, (imageFile) {
      imageList.add(imageFile);
      emit(PickImageSuccess(
        updatedImageList: imageList,
      ));
    });
  }

  Future<void> _removeImage(
      RemoveImageEvent event, Emitter<DiaryState> emit) async {
    try {
      emit(RemoveImageLoading());

      final List<XFile> updatedImageList = event.imageList
        ..removeAt(event.index);

      emit(RemoveImageSuccess(updatedImageList: updatedImageList));
    } catch (error) {
      log('_removeImage error: $error');
      emit(RemoveImageFailed());
    }
  }

  Future<void> _uploadDiary(
      UploadDiaryEvent event, Emitter<DiaryState> emit) async {
    emit(UploadDiaryLoading());

    final List<File> fileList =
        event.imageList.map<File>((xfile) => File(xfile.path)).toList();
    final List<String> fileListToBase64 =
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
        print(failure);
        emit(
          const UploadDiaryFailed(
            errorMessage: 'Failed to upload the diary.',
          ),
        );
        return;
      },
      (uploadedDiaryResult) {
        if (int.parse(uploadedDiaryResult.id) > 0) {
          emit(UploadDiarySuccess());
          return;
        } else {
          emit(
            const UploadDiaryFailed(
              errorMessage: 'Failed to upload the diary.',
            ),
          );
        }
      },
    );
  }
}
