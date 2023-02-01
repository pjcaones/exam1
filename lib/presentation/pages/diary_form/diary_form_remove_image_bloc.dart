part of 'diary_form_bloc.dart';

extension RemoveImageBloc on AddPhotoBloc {
  Future<void> _removeImage(
      RemoveImageEvent event, Emitter<AddPhotoState> emit) async {
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
}
