import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:exam1/features/diary/presentation/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  late DiaryBloc diaryBloc;

  setUp(() {
    diaryBloc = MockDiaryBloc();
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
          value: diaryBloc,
          child: const DiaryStatesWidget(),
        ));
  }

  group('test for diary states', () {
    testWidgets('upload diary loading state', (tester) async {
      whenListen(
        diaryBloc,
        Stream.fromIterable(
          [
            UploadDiaryLoading(),
          ],
        ),
        initialState: DiaryInitial(),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widgetUnderTest());
      });

      await tester.pump();
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('upload diary success state', (tester) async {
      whenListen(
        diaryBloc,
        Stream.fromIterable(
          [
            UploadDiarySuccess(),
          ],
        ),
        initialState: DiaryInitial(),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widgetUnderTest());
      });

      await tester.pump();

      expect(find.text('Your diary has been uploaded!'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pump();

      expect(find.text('Your diary has been uploaded!'), findsNothing);
      expect(find.text('OK'), findsNothing);
    });

    testWidgets('upload diary failed state', (tester) async {
      whenListen(
        diaryBloc,
        Stream.fromIterable(
          [
            const UploadDiaryFailed(),
          ],
        ),
        initialState: DiaryInitial(),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(widgetUnderTest());
      });

      await tester.pump();
      expect(find.text('Upload Failed'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pump();

      expect(find.text('Upload Failed'), findsNothing);
      expect(find.text('OK'), findsNothing);
    });
  });
}
