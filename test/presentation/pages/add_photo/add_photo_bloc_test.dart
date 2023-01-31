import 'dart:io';

import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/entities/diary.dart';
import 'package:exam1/domain/entities/uploaded_diary_result.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:exam1/presentation/pages/add_photo/add_photo_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockUploadDiary extends Mock implements UploadDiary {
  @override
  Future<Either<Failure, UploadedDiaryResult>> call({required Diary params}) =>
      super.noSuchMethod(Invocation.getter(#params));
}

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

  final tDiary = Diary(
    location: location,
    imageList: tConvertedFileList,
    comment: comment,
    diaryDateInMillis: diaryDateInMillis,
    areaID: areaID,
    taskCategoryID: taskCategoryID,
    tags: tags,
    eventID: eventID,
  );

  const tUploadedDiaryResult = UploadedDiaryResult(id: '1');

  final uploadDiaryEvent = UploadDiaryEvent(
      location: location,
      imageList: [
        XFile('Test1.png'),
        XFile('Test2.png'),
        XFile('Test3.png'),
      ],
      comment: comment,
      diaryDate: diaryDateInMillis,
      areaID: areaID,
      taskCategoryID: taskCategoryID,
      tags: tags,
      eventID: eventID);

  group('For pressing the next button', () {
    test('should call the usecase first for checking', () async {
      when(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          )).thenAnswer((_) async => tConvertedFileList);

      final result = await mockFileToBase64.listConversion(fileList: [
        File('test 1.png'),
        File('test 2.png'),
        File('test 3.png'),
      ]);

      expect(result, tConvertedFileList);

      //Actual calling of usecase
      when(
        () => mockUploadDiary(params: tDiary),
      ).thenAnswer((_) async => const Right(tUploadedDiaryResult));

      final mockResult = await mockUploadDiary(params: tDiary);

      verify(() => mockUploadDiary(params: tDiary));

      expect(mockResult, const Right(tUploadedDiaryResult));
    });

    test('should get the from use case function', () async {
      when(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          )).thenAnswer((_) async => tConvertedFileList);
      when(() => mockUploadDiary(params: tDiary))
          .thenAnswer((_) async => const Right(tUploadedDiaryResult));

      expect(addPhotoBloc, isA<AddPhotoBloc>());
      expect(tDiary, isA<Diary>());

      addPhotoBloc.add(uploadDiaryEvent);

      await untilCalled(
        () => mockUploadDiary(params: tDiary),
      );
      verify(() => mockUploadDiary(params: tDiary));
    });

    test('should emit states from loading to success', () async* {
      when(() => mockFileToBase64.listConversion(
            fileList: any(named: 'fileList'),
          )).thenAnswer((_) async => tConvertedFileList);
      when(() => mockUploadDiary(params: any(named: 'params')))
          .thenAnswer((_) async => const Right(tUploadedDiaryResult));

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
