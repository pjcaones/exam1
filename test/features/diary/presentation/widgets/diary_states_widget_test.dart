import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/domain/entities/entities.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

class FakeDiaryEvent extends Fake implements DiaryEvent {}

class FakeDiaryState extends Fake implements DiaryState {}

void main() {
  late MockDiaryBloc mockDiaryBloc;
  late DiaryBloc diaryBloc;
  late GetIt di;

  di = GetIt.instance
    ..registerFactory(
      () => mockDiaryBloc,
    );

  setUp(() {
    mockDiaryBloc = MockDiaryBloc();
  });

  const Diary tDiary = Diary(
    location: 'Sample location',
    imageList: [
      'test1.png',
      'test2.png',
      'test3.png',
    ],
    comment: 'Sample comment',
    diaryDateInMillis: 11111,
    areaID: 1,
    taskCategoryID: 1,
    tags: 'sample tag',
    eventID: 1,
  );

  Widget widgetUnderTest() {
    return MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider<DiaryBloc>.value(
          value: mockDiaryBloc,
          child: const DiaryStatesWidget(),
        ));
  }

  group('test for diary states', () {
    testWidgets('upload diary loading state', (tester) async {
      // final buttonFinder = find.byKey(const Key('next'));
      // when(() => mockDiaryBloc.state).thenReturn(UploadDiaryLoading());
      when(() => mockDiaryBloc.state).thenReturn(DiaryInitial());

      final expectedStates = [
        DiaryInitial(),
        UploadDiaryLoading(),
      ];

      whenListen(mockDiaryBloc, Stream.fromIterable(expectedStates));

      await tester.runAsync(() async {
        await tester.pumpWidget(widgetUnderTest());

        final state = mockDiaryBloc.state;
        expect(state, UploadDiaryLoading());
      });

      // await expectLater(find.text('Loading...'), findsOneWidget);

      // expect(buttonFinder, findsOneWidget);
      // await tester.ensureVisible(buttonFinder);
      // await tester.tap(buttonFinder);
      // await tester.pumpAndSettle();
    });

    testWidgets('upload diary success state', (tester) async {
      when(() => mockDiaryBloc.state).thenReturn(UploadDiarySuccess());

      await tester.pumpWidget(widgetUnderTest());

      final state = mockDiaryBloc.state;
      expect(state, UploadDiarySuccess());

      // await tester.pumpAndSettle(const Duration(seconds: 3));
      // expect(find.text('Your diary has been uploaded!'), findsOneWidget);
    });

    testWidgets('upload diary failed state', (tester) async {
      when(() => mockDiaryBloc.state).thenReturn(
        const UploadDiaryFailed(
          errorMessage: 'upload failed',
        ),
      );

      await tester.pumpWidget(widgetUnderTest());

      final state = mockDiaryBloc.state;
      expect(
        state,
        const UploadDiaryFailed(
          errorMessage: 'upload failed',
        ),
      );

      // expect(find.byType(Dialog), findsOneWidget);

      // expect(find.byType(LinearProgressIndicator), findsOneWidget);
      // expect(find.text('Loading...'), findsOneWidget);
    });
  });

  testWidgets('Sample test with alert dialog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                // showDialog(
                //   context: tester.element(find.byType(ElevatedButton)),
                //   builder: (context) {
                //     return AlertDialog(
                //       title: const Text('Sample Title'),
                //       content: const Text('Sample Content'),
                //       actions: [
                //         TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: const Text('OK'),
                //         )
                //       ],
                //     );
                //   },
                // );

                ProgressDialog(
                        tester.element(
                          find.byType(ElevatedButton),
                        ),
                        type: ProgressDialogType.normal,
                        isDismissible: false)
                    .show();
              },
              child: const Text('press me!'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    //For progress dialog
    // expect(find.text('Loading...'), findsOneWidget);

    //For dialog test
    // expect(find.byType(AlertDialog), findsOneWidget);
    // expect(find.text('Sample Title'), findsOneWidget);
    // expect(find.text('Sample Content'), findsOneWidget);
  });
}
