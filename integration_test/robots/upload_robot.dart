import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class UploadRobot {
  const UploadRobot(this.tester);

  final WidgetTester tester;

  Future<void> uploadDiary() async {
    final buttonFinder = find.byKey(const Key('next'));

    expect(buttonFinder, findsOneWidget);
    await tester.ensureVisible(buttonFinder);

    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text('Loading...'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Your diary has been uploaded!'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Your diary has been uploaded!'), findsNothing);
    expect(find.text('OK'), findsNothing);
  }
}
