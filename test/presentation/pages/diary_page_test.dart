import 'dart:math';

import 'package:exam1/core/errors/failures.dart';
import 'package:exam1/core/helpers/image_to_base64.dart';
import 'package:exam1/domain/entities/entities.dart';
import 'package:exam1/domain/usecases/upload_diary.dart';
import 'package:exam1/presentation/helpers/image_helper.dart';
import 'package:exam1/presentation/pages/add_photo/add_photo_bloc.dart';
import 'package:exam1/presentation/pages/diary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import 'package:exam1/injection_container.dart' as get_it;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class MockFileToBase64 extends Mock implements FileToBase64 {}

class MockImageHelper extends Mock implements ImageHelper {}

class MockUploadDiary extends Mock implements UploadDiary {
  @override
  Future<Either<Failure, UploadedDiaryResult>> call({required Diary params}) =>
      super.noSuchMethod(Invocation.getter(#params));
}

void main() {
  late MockFileToBase64 mockFileToBase64;
  late MockUploadDiary mockUploadDiary;
  late MockImageHelper mockImagePicker;

  setUp(() {
    // get_it.init();
    mockFileToBase64 = MockFileToBase64();
    mockUploadDiary = MockUploadDiary();
    mockImagePicker = MockImageHelper();
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
    testWidgets(
      'should load the scaffold with the right properties',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest());

        final appbarFinder = find.byType(AppBar);
        expect(appbarFinder, findsOneWidget);

        final appBar = widgetTester.firstWidget<AppBar>(appbarFinder);
        expect(appBar.title, isA<Text>());

        Text appBarText = appBar.title as Text;
        expect(appBarText.data, 'New Diary');

        IconButton appBarLeadingIcon = appBar.leading as IconButton;
        Icon leadingIcon = appBarLeadingIcon.icon as Icon;
        expect(leadingIcon.icon, Icons.close_sharp);
      },
    );

    testWidgets(
      'should have location loaded',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest());
        expect(find.byIcon(Icons.location_on), findsOneWidget);
      },
    );

    testWidgets(
      'should added photos',
      (widgetTester) async {
        XFile mockImage = XFile('Sample.png');
        List<XFile> mockImageList = [];

        //Concern not sure if this is the way to use ImagePicker in widget testing
        //Currently not displaying the image

        when(
          () => mockImagePicker.pickImage(source: ImageSource.gallery),
        ).thenAnswer((_) async => mockImage);

        await widgetTester.pumpWidget(widgetUnderTest());

        //Check first if the button add photo was loaded
        expect(find.byKey(buttonAddPhoto), findsOneWidget);
        await widgetTester.tap(find.byKey(buttonAddPhoto));
        await widgetTester.pumpAndSettle();

        final mockPickedImage =
            await mockImagePicker.pickImage(source: ImageSource.gallery);

        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        verify(() => mockImagePicker.pickImage(source: ImageSource.gallery));

        mockImageList.add(mockPickedImage!);
        await widgetTester.pump();

        expect(mockImageList.length, 1);
        // expect(find.byType(Image), findsNWidgets(mockImageList.length));
      },
    );

    testWidgets('Check if the date in details displayed is date today',
        (widgetTester) async {
      DateFormat format = DateFormat('yyyy-MM-dd');
      int dateNow = DateTime.now().millisecondsSinceEpoch;
      String sDateNow =
          format.format(DateTime.fromMillisecondsSinceEpoch(dateNow));

      await widgetTester.pumpWidget(widgetUnderTest());

      final inputFieldFinder = find.byKey(const Key('diary_date'));
      expect(inputFieldFinder, findsOneWidget);

      final inputFieldDiaryDate =
          widgetTester.firstWidget<TextField>(inputFieldFinder);
      expect(inputFieldDiaryDate.controller?.text, sDateNow);
    });

    testWidgets('Check the content of area dropdown', (widgetTester) async {
      // DropdownMenuItem dropdownItem;
      int selectedValue = 0;
      await widgetTester.pumpWidget(widgetUnderTest());

      final dropdownFinder = find.byKey(const Key('area'));
      expect(dropdownFinder, findsOneWidget);

      await widgetTester.ensureVisible(dropdownFinder);

      //Concern
      //Getting the value of selected dropdown here..

      await widgetTester.tap(dropdownFinder);
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text('Area 1').last);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Check the content of category dropdown', (widgetTester) async {
      // DropdownMenuItem dropdownItem;
      int selectedValue = 0;
      await widgetTester.pumpWidget(widgetUnderTest());

      final dropdownFinder = find.byKey(const Key('category'));
      expect(dropdownFinder, findsOneWidget);

      await widgetTester.ensureVisible(dropdownFinder);

      //Concern
      //Getting the value of selected dropdown here..

      await widgetTester.tap(dropdownFinder);
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text('Task Category 1').last);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('Check the content of event dropdown', (widgetTester) async {
      // DropdownMenuItem dropdownItem;
      int selectedValue = 0;
      await widgetTester.pumpWidget(widgetUnderTest());

      final dropdownFinder = find.byKey(const Key('event'));
      expect(dropdownFinder, findsOneWidget);

      await widgetTester.ensureVisible(dropdownFinder);

      //Concern
      //Getting the value of selected dropdown here..

      await widgetTester.tap(dropdownFinder);
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text('Event 1').last);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    });

    //Sample data to be uploaded
    String location = 'location';
    String comment = 'comment';
    int diaryDateInMillis = DateTime.now().millisecondsSinceEpoch;
    int areaID = 1;
    int taskCategoryID = 1;
    String tags = 'Sample Tag';
    int eventID = 1;

    //Sample converted base64 from sample selected images
    List<String> tConvertedFileList = ['Test 1', 'Test 2', 'Test 3'];

    Diary tDiary = Diary(
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

    testWidgets(
      'should check whether the page has 1 next button',
      (widgetTester) async {
        AddPhotoBloc mockAddPhotoBloc = AddPhotoBloc(
          fileToBase64: mockFileToBase64,
          uploadDiary: mockUploadDiary,
        );

        final instance = GetIt.instance;
        instance.registerFactory<AddPhotoBloc>(() => mockAddPhotoBloc);

        await widgetTester.pumpWidget(widgetUnderTest());

        await widgetTester.ensureVisible(find.byKey(buttonNext));
        expect(find.byKey(buttonNext), findsOneWidget);

        when(() => mockFileToBase64.listConversion(
              fileList: any(named: 'fileList'),
            )).thenAnswer((_) async => tConvertedFileList);
        when(
          () => mockUploadDiary(params: tDiary),
        ).thenAnswer((_) async => const Right(tUploadedDiaryResult));

        await widgetTester.tap(find.byKey(buttonNext));
        await widgetTester.pumpAndSettle();

        // when(() => mockAddPhotoBloc.state).thenReturn(UploadDiaryLoading());

        await untilCalled(() =>
            mockFileToBase64.listConversion(fileList: any(named: 'fileList')));
        await untilCalled(() => mockUploadDiary(params: tDiary));

        verify(() =>
            mockFileToBase64.listConversion(fileList: any(named: 'fileList')));
        verify(() => mockUploadDiary(params: tDiary));

        await widgetTester.pumpAndSettle();
        expect(mockAddPhotoBloc.state, UploadDiarySuccess());

        // expect(find.byType(ProgressDialog), findsOneWidget);
        // await expectLater(find.text('Upload Success'), findsOneWidget);
      },
    );
  });
}
