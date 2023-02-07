import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' as di;
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  late MockDiaryBloc mockDiaryBloc;
  final GetIt di = GetIt.instance;

  setUp(() {
    mockDiaryBloc = MockDiaryBloc();

    di.registerFactory<DiaryBloc>(
      () => mockDiaryBloc,
    );
  });

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
          value: di<DiaryBloc>(),
          child: const DiaryStatesWidget(),
        ));
  }

  group('test for diary states', () {
    final buttonFinder = find.byKey(const Key('next'));

    testWidgets('upload diary loading state', (tester) async {
      when(() => di<DiaryBloc>().state).thenReturn(UploadDiaryLoading());

      await tester.pumpWidget(widgetUnderTest());

      expect(buttonFinder, findsOneWidget);
      await tester.ensureVisible(buttonFinder);
      await tester.tap(buttonFinder);
      await tester.pump();

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('upload diary success state', (tester) async {
      when(() => mockDiaryBloc.state).thenReturn(UploadDiarySuccess());

      await tester.pumpWidget(widgetUnderTest());

      expect(buttonFinder, findsOneWidget);
      await tester.ensureVisible(buttonFinder);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // expect(find.text('Your diary has been uploaded!'), findsOneWidget);
    });

    testWidgets('upload diary failed state', (tester) async {
      when(() => mockDiaryBloc.state).thenReturn(
        const UploadDiaryFailed(
          errorMessage: 'upload failed',
        ),
      );

      when(() => mockDiaryBloc.state).thenReturn(UploadDiarySuccess());

      await tester.pumpWidget(widgetUnderTest());

      expect(buttonFinder, findsOneWidget);
      await tester.ensureVisible(buttonFinder);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // expect(find.byType(AlertDialog), findsOneWidget);
      // expect(find.text('Upload Failed'), findsOneWidget);
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
    expect(find.text('Loading...'), findsOneWidget);

    //For dialog test
    // expect(find.byType(AlertDialog), findsOneWidget);
    // expect(find.text('Sample Title'), findsOneWidget);
    // expect(find.text('Sample Content'), findsOneWidget);
  });
}
