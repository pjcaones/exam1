import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_photo_event.dart';
part 'add_photo_state.dart';

class AddPhotoBloc extends Bloc<AddPhotoEvent, AddPhotoState> {
  AddPhotoBloc() : super(AddPhotoInitial()) {
    on<AddPhotoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
