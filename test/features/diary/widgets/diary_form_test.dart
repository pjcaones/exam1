import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  DiaryState? returnedState;

  late DiaryBloc diaryBloc;
  setUp(() {
    diaryBloc = MockDiaryBloc();
  });

  Widget widgetUnderTest({List<XFile>? imageList}) {
    return MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider<DiaryBloc>.value(
          value: diaryBloc,
          child: BlocListener<DiaryBloc, DiaryState>(
            listener: (context, state) {
              returnedState = state;
            },
            child: SingleChildScrollView(
              child: DiaryForm(
                imageList: imageList,
              ),
            ),
          ),
        ));
  }

  final XFile tImage = XFile('test1.png');
  List<XFile> tUpdatedImageList = [];

  void setMockDiaryInitialSuccessState() {
    when(() => diaryBloc.state).thenReturn(
      DiaryInitialLoadSuccess(
          location: '20041075 | TAP-NS TAP-North Strathfield',
          areas: const {
            1: 'Area 1',
            2: 'Area 2',
            3: 'Area 3',
          },
          categories: const {
            1: 'Task Category 1',
            2: 'Task Category 2',
            3: 'Task Category 3',
          },
          events: const {
            1: 'Event 1',
            2: 'Event 2',
            3: 'Event 3',
          },
          diaryDate: DateTime.now().millisecondsSinceEpoch),
    );
  }

  group('add photo section', () {
    testWidgets('diary form pick and remove image', (tester) async {
      tUpdatedImageList = [
        tImage,
      ];

      //Picking of image
      final btnAddPhotoFinder = find.byKey(const Key('add_photo'));
      whenListen(
          diaryBloc,
          Stream.fromIterable(
            [
              PickImageLoading(),
              PickImageSuccess(updatedImageList: tUpdatedImageList)
            ],
          ),
          initialState: DiaryInitial());

      await tester.pumpWidget(widgetUnderTest());
      expect(btnAddPhotoFinder, findsOneWidget);

      await tester.tap(btnAddPhotoFinder);
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('removing of image', (tester) async {
      tUpdatedImageList = [
        tImage,
      ];

      whenListen(
          diaryBloc,
          Stream.fromIterable(
            [
              RemoveImageLoading(),
              const RemoveImageSuccess(updatedImageList: [])
            ],
          ),
          initialState: DiaryInitial());

      final removePhotoFinder = find.byKey(const Key('remove_image_button_0'));
      await tester.pumpWidget(widgetUnderTest(imageList: tUpdatedImageList));

      expect(removePhotoFinder, findsOneWidget);
      await tester.tap(removePhotoFinder);
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsNothing);
    });

    testWidgets('include photo gallery', (tester) async {
      final checkboxFinder = find.byKey(const Key('include_gallery'));
      when(() => diaryBloc.state).thenReturn(DiaryInitial());

      await tester.pumpWidget(widgetUnderTest());
      expect(checkboxFinder, findsOneWidget);

      expect(tester.firstWidget<Checkbox>(checkboxFinder).value, true);

      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();

      expect(tester.firstWidget<Checkbox>(checkboxFinder).value, false);
    });
  });

  testWidgets('for link event', (tester) async {
    final checkboxFinder = find.byKey(const Key('existing_event'));
    when(() => diaryBloc.state).thenReturn(DiaryInitial());

    await tester.pumpWidget(widgetUnderTest());
    await tester.ensureVisible(checkboxFinder);
    expect(checkboxFinder, findsOneWidget);

    expect(tester.firstWidget<Checkbox>(checkboxFinder).value, true);

    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    expect(tester.firstWidget<Checkbox>(checkboxFinder).value, false);
  });

  testWidgets('for dropdown area', (tester) async {
    final dropdownFinder = find.byKey(const Key('area'));
    setMockDiaryInitialSuccessState();

    await tester.pumpWidget(widgetUnderTest());
    await tester.ensureVisible(dropdownFinder);
    expect(dropdownFinder, findsOneWidget);

    await tester.tap(dropdownFinder);
    await tester.pump();

    await tester.tap(find.text('Area 3').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Area 3'), findsOneWidget);

    //became title of textfield
    expect(find.text('Select Area'), findsOneWidget);
  });

  testWidgets('for category', (tester) async {
    final dropdownFinder = find.byKey(const Key('category'));
    setMockDiaryInitialSuccessState();

    await tester.pumpWidget(widgetUnderTest());
    await tester.ensureVisible(dropdownFinder);
    expect(dropdownFinder, findsOneWidget);

    await tester.tap(dropdownFinder);
    await tester.pump();

    await tester.tap(find.text('Task Category 3').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Task Category 3'), findsOneWidget);

    //became title of textfield
    expect(find.text('Task Category'), findsOneWidget);
  });

  testWidgets('for event', (tester) async {
    final dropdownFinder = find.byKey(const Key('event'));
    setMockDiaryInitialSuccessState();

    await tester.pumpWidget(widgetUnderTest());
    await tester.ensureVisible(dropdownFinder);
    expect(dropdownFinder, findsOneWidget);

    await tester.tap(dropdownFinder);
    await tester.pump();

    await tester.tap(find.text('Event 3').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Event 3'), findsOneWidget);

    //became title of textfield
    expect(find.text('Select an event'), findsOneWidget);
  });

  testWidgets('should return state as expected', (tester) async {
    final buttonFinder = find.byKey(const Key('next'));

    whenListen(
        diaryBloc,
        Stream.fromIterable(
          [
            UploadDiarySuccess(),
          ],
        ),
        initialState: DiaryInitial());

    await tester.pumpWidget(widgetUnderTest());
    expect(buttonFinder, findsOneWidget);

    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(returnedState, isA<UploadDiarySuccess>());
  });
}
