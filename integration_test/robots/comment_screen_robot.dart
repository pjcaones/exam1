import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CommentScreenRobot {
  const CommentScreenRobot(this.tester);

  final WidgetTester tester;

  Future<void> inputComment({String? inputText}) async {
    final textFieldFinder = find.byKey(const Key('comment'));
    final String comment = inputText ?? 'Sample Text';

    expect(textFieldFinder, findsOneWidget);
    await tester.tap(textFieldFinder);
    await tester.pump();

    await tester.enterText(textFieldFinder, comment);
    await tester.pumpAndSettle();
  }
}
