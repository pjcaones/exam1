import 'dart:io';

import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/entities/diary.dart';
import 'package:exam1/domain/entities/uploaded_diary_result.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:exam1/presentation/pages/add_photo/add_photo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockUploadDiary extends Mock implements UploadDiary {}

void main() {
  late AddPhotoBloc addPhotoBloc;
  late MockFileToBase64 mockFileToBase64;
  late MockUploadDiary mockUploadDiary;

  setUp(() {
    mockFileToBase64 = MockFileToBase64();
    mockUploadDiary = MockUploadDiary();

    addPhotoBloc = AddPhotoBloc(
      fileToBase64: mockFileToBase64,
      uploadDiary: mockUploadDiary,
    );
  });

  //Sample selected images from UI
  List<File> tFileList = [
    File('test1.png'),
    File('test2.png'),
    File('test3.png'),
  ];

  //Sample converted base64 from sample selected images
  List<String> tConvertedFileList = ['Test 1', 'Test 2', 'Test 3'];

  //Sample data to be uploaded
  String location = 'location';
  String comment = 'comment';
  int diaryDateInMillis = DateTime.now().millisecondsSinceEpoch;
  int areaID = 1;
  int taskCategoryID = 1;
  String tags = 'Sample Tag';
  int eventID = 1;

  const tUploadedDiaryResult = UploadedDiaryResult(diaryID: 1);

  group('For pressing the next button', () {
    test('should convert first the image to base64', () async {
      when(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          )).thenAnswer((_) async => tConvertedFileList);

      addPhotoBloc.add(UploadDiaryEvent(
          location: location,
          imageList: [
            XFile('Test1.png'),
            XFile('Test2.png'),
            XFile('Test3.png')
          ],
          comment: comment,
          diaryDate: diaryDateInMillis,
          areaID: areaID,
          taskCategoryID: taskCategoryID,
          tags: tags,
          eventID: eventID));

      await untilCalled(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          ));

      verify(() =>
          mockFileToBase64.listConversion(fileList: any(named: 'fileList')));
    });

    test('should get the from use case function', () async {
      when(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          )).thenAnswer((_) async => tConvertedFileList);
      when(() => mockUploadDiary(params: any(named: 'params')))
          .thenAnswer((_) async => tUploadedDiaryResult);

      addPhotoBloc.add(UploadDiaryEvent(
          location: location,
          imageList: [
            XFile('Test1.png'),
            XFile('Test2.png'),
            XFile('Test3.png')
          ],
          comment: comment,
          diaryDate: diaryDateInMillis,
          areaID: areaID,
          taskCategoryID: taskCategoryID,
          tags: tags,
          eventID: eventID));

      await untilCalled(() => mockUploadDiary(params: any(named: 'params')));
      verify(() => mockUploadDiary(
          params: Diary(
              location: location,
              imageList: tConvertedFileList,
              comment: comment,
              diaryDateInMillis: diaryDateInMillis,
              areaID: areaID,
              taskCategoryID: taskCategoryID,
              tags: tags,
              eventID: eventID)));
    });

    test('should emit states from loading to success', () async* {
      when(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          )).thenAnswer((_) async => tConvertedFileList);
      when(() => mockUploadDiary(params: any(named: 'params')))
          .thenAnswer((_) async => tUploadedDiaryResult);

      //expected emits
      final expectedEmits = [
        AddPhotoInitial(),
        UploadDiaryLoading(),
        UploadDiarySuccess(),
      ];

      expectLater(addPhotoBloc, emitsInOrder(expectedEmits));
      addPhotoBloc.add(UploadDiaryEvent(
          location: location,
          imageList: [
            XFile('Test1.png'),
            XFile('Test2.png'),
            XFile('Test3.png')
          ],
          comment: comment,
          diaryDate: diaryDateInMillis,
          areaID: areaID,
          taskCategoryID: taskCategoryID,
          tags: tags,
          eventID: eventID));
    });
  });
}
