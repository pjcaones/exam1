part of 'diary_form_bloc.dart';

extension PickImageBloc on AddPhotoBloc {
  void _pickImage(PickImageEvent event, Emitter<AddPhotoState> emit) async {
    emit(PickImageLoading());

    List<XFile> imageList = event.imageList;
    final failOrImage = await pickImage(ImageSource.gallery);

    failOrImage.fold((fail) {
      log('_uploadDiary error: $fail');
      emit(PickImageFailed());
    }, (imageFile) {
      imageList.add(imageFile);
      emit(PickImageSuccess(
        updatedImageList: imageList,
      ));
    });
  }
}
