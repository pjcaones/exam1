part of 'diary_form_bloc.dart';

extension RemoveImageBloc on AddPhotoBloc {
  void _removeImage(RemoveImageEvent event, Emitter<AddPhotoState> emit) async {
    try {
      emit(RemoveImageLoading());

      List<XFile> updatedImageList = event.imageList;
      updatedImageList.removeAt(event.index);

      emit(RemoveImageSuccess(updatedImageList: updatedImageList));
    } catch (error) {
      log('_removeImage error: $error');
      emit(RemoveImageFailed());
    }
  }
}
