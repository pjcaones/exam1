import 'dart:io';

import 'package:exam1/features/diary/di.dart' as get_it;
import 'package:exam1/features/diary/pages/pages.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  get_it.init();

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
      home: const DiaryPage(),
    );
  }

  testWidgets('diary form page', (tester) async {
    await tester.pumpWidget(widgetUnderTest());

    final appbarFinder = find.byType(AppBar);
    expect(appbarFinder, findsOneWidget);

    final appBar = tester.firstWidget<AppBar>(appbarFinder);
    expect(appBar.title, isA<Text>());

    final Text appBarText = appBar.title as Text;
    expect(appBarText.data, 'New Diary');

    final IconButton appBarLeadingIcon = appBar.leading as IconButton;
    final Icon leadingIcon = appBarLeadingIcon.icon as Icon;
    expect(leadingIcon.icon, Icons.close_sharp);
  });

  testWidgets('diary form close app', (tester) async {
    await tester.pumpWidget(widgetUnderTest());

    await tester.tap(find.byIcon(Icons.close_sharp));
    await tester.pump();

    expect(exitCode, 0);
  });

  //Golden Test
  // testGoldens('running a sample golden test', (tester) async {
  //   await loadAppFonts();
  //   // await tester.pumpWidgetBuilder(widgetUnderTest());
  //   final builder = DeviceBuilder()..addScenario(widget: widgetUnderTest());
  //   await tester.pumpDeviceBuilder(builder);

  //   await screenMatchesGolden(tester, 'test');
  // });
}
