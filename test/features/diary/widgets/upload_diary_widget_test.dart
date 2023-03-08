import 'package:bloc_test/bloc_test.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:exam1/src/features/diary/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDiaryBloc extends MockBloc<DiaryEvent, DiaryState>
    implements DiaryBloc {}

void main() {
  String? returnValueFromUploadButton;

  Widget widgetUnderTest() {
    return MaterialApp(
      title: 'Exam 1',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: UploadDiaryWidget(
        onUploadDiaryForm: () {
          returnValueFromUploadButton = 'Tapped';
        },
      ),
    );
  }

  testWidgets('should pass all properties', (tester) async {
    final buttonFinder = find.byKey(const Key('next'));

    await tester.pumpWidget(widgetUnderTest());

    expect(buttonFinder, findsOneWidget);

    final buttonNext = tester.firstWidget<ElevatedButton>(buttonFinder);
    expect(
      find.ancestor(
        of: buttonFinder,
        matching: find.byType(SizedBox),
      ),
      findsOneWidget,
    );

    final buttonChildWidget = buttonNext.child;
    expect(buttonChildWidget, isA<Text>());
    expect((buttonChildWidget as Text).data, 'Next');

    await tester.tap(buttonFinder);
    await tester.pump();

    expect(returnValueFromUploadButton, 'Tapped');
  });
}
