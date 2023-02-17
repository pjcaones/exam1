import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

enum UploadResult {
  success,
  fail,
}

class UploadRobot {
  const UploadRobot(this.tester);

  final WidgetTester tester;

  Future<void> uploadDiary({required UploadResult uploadResult}) async {
    final buttonFinder = find.byKey(const Key('next'));

    expect(buttonFinder, findsOneWidget);
    await tester.ensureVisible(buttonFinder);

    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text('Loading...'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    switch (uploadResult) {
      case UploadResult.success:
        await resultSuccess();
        break;
      case UploadResult.fail:
        await resultFailed();
        break;
    }
  }

  Future<void> resultSuccess() async {
    expect(find.text('Your diary has been uploaded!'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Your diary has been uploaded!'), findsNothing);
    expect(find.text('OK'), findsNothing);
  }

  Future<void> resultFailed() async {
    expect(find.text('Upload Failed'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Upload Failed'), findsNothing);
    expect(find.text('OK'), findsNothing);
  }
}
