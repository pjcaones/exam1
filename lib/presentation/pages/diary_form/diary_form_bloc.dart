import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/entities/entities.dart';
import 'package:exam1/domain/usecases/pick_image.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'diary_form_event.dart';
part 'diary_form_state.dart';
part 'diary_form_pick_image_bloc.dart';
part 'diary_form_remove_image_bloc.dart';
part 'diary_form_upload_diary_bloc.dart';

class AddPhotoBloc extends Bloc<AddPhotoEvent, AddPhotoState> {
  final FileToBase64 fileToBase64;
  final PickImage pickImage;
  final UploadDiary uploadDiary;

  AddPhotoBloc({
    required this.fileToBase64,
    required this.pickImage,
    required this.uploadDiary,
  }) : super(AddPhotoInitial()) {
    on<UploadDiaryEvent>(_uploadDiary);
    on<PickImageEvent>(_pickImage);
    on<RemoveImageEvent>(_removeImage);
  }
}
