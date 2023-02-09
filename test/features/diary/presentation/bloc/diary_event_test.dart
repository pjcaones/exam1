import 'package:exam1/features/diary/bloc/diary_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

class ConcreteDiaryEvent extends DiaryEvent {}

void main() {
  final List<XFile> fileList = [
    XFile('sample1.png'),
    XFile('sample2.png'),
    XFile('sample3.png'),
  ];

  final PickImageEvent pickImageEvent = PickImageEvent(
    imageList: fileList,
  );

  final RemoveImageEvent removeImageEvent = RemoveImageEvent(
    index: 1,
    imageList: fileList,
  );

  final UploadDiaryEvent uploadDiaryEvent = UploadDiaryEvent(
    location: 'Sample location',
    imageList: fileList,
    comment: 'sample comment',
    diaryDate: 10000,
    areaID: 1,
    taskCategoryID: 1,
    tags: 'sample tags',
    eventID: 1,
  );

  final ConcreteDiaryEvent diaryEvent = ConcreteDiaryEvent();

  group('diary events', () {
    test('pick image event', () async {
      final List<Object?> props = [
        fileList,
        ImageSource.gallery,
      ];

      expect(pickImageEvent.props, props);
    });

    test('remove image event', () async {
      final List<Object?> props = [
        1,
        fileList,
      ];

      expect(removeImageEvent.props, props);
    });

    test('upload diary event', () async {
      final List<Object?> props = [
        'Sample location',
        fileList,
        'sample comment',
        10000,
        1,
        1,
        'sample tags',
        1,
      ];

      expect(uploadDiaryEvent.props, props);
    });

    test('diary event', () {
      expect(diaryEvent.props, []);
    });
  });
}
