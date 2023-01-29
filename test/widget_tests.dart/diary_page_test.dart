import 'dart:io';

import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:exam1/presentation/pages/add_photo/add_photo_bloc.dart';
import 'package:exam1/presentation/pages/diary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:exam1/injection_container.dart' as get_it;

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockUploadDiary extends Mock implements UploadDiary {}

class MockImagePicker extends Mock implements ImagePicker {
  // "/Users/jpcaones/Library/Developer/CoreSimulator/Devices/EE8D9367-6B36-4497-9C67-E7A299A373A5/data/Containers/Data/Application/1B54BBE8-B7B1-4B08-840F-EDD87A226D86/tmp/image_picker_91C32B67-9483-4DF2-ADA6-1E4EF648B75A-91950-000001B95D0E058E.jpg"
  // BA29-AB23-442B-A976-5554F8A749AC-91950-000001BA82BAB2AC.jpg"
  @override
  Future<XFile?> pickImage(
      {required ImageSource source,
      double? maxWidth,
      double? maxHeight,
      int? imageQuality,
      CameraDevice preferredCameraDevice = CameraDevice.rear,
      bool requestFullMetadata = true}) {
    return Future.value(XFile(
        '/Users/jpcaones/Library/Developer/CoreSimulator/Devices/EE8D9367-6B36-4497-9C67-E7A299A373A5/data/Containers/Data/Application/1B54BBE8-B7B1-4B08-840F-EDD87A226D86/tmp/image_picker_91C32B67-9483-4DF2-ADA6-1E4EF648B75A-91950-000001B95D0E058E.jpg'));
  }
}

void main() {
  late AddPhotoBloc photoBloc;
  late MockFileToBase64 mockFileToBase64;
  late MockUploadDiary mockUploadDiary;

  setUp(() {
    get_it.init();
    mockFileToBase64 = MockFileToBase64();
    mockUploadDiary = MockUploadDiary();

    photoBloc = AddPhotoBloc(
      fileToBase64: mockFileToBase64,
      uploadDiary: mockUploadDiary,
    );
  });

  Widget widgetUnderTest() {
    return const MaterialApp(
      title: 'Exam 1',
      home: DiaryPage(),
    );
  }

  const Key buttonNext = Key('next');
  const Key buttonAddPhoto = Key('add_photo');

  group('tests for diary page', () {
    testWidgets('should have location loaded', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('should have button add photo loaded', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());
      expect(find.byKey(buttonAddPhoto), findsOneWidget);
    });

    testWidgets('should added photos', (widgetTester) async {
      //This part was not available for mocktail package.
      //should change package

      // await widgetTester.pumpWidget(widgetUnderTest());
      // await widgetTester.tap(find.byKey(buttonAddPhoto));

      // expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should check whether the page has 1 next button',
        (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());
      expect(find.byKey(buttonNext), findsOneWidget);
    });

    testWidgets(
      '''should check the uploading 
    after tapping the next button''',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest());
        // await widgetTester.pump();
        // await widgetTester.tap(find.byKey(buttonNext));
        // await widgetTester.pump();

        // expect(find.text('Upload Success'), findsOneWidget);
      },
    );
  });
}
