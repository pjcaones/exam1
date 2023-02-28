import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class EventScreenRobot {
  const EventScreenRobot(this.tester);

  final WidgetTester tester;

  Future<void> selectEvent({String? eventSelected}) async {
    final Future<void> pumpWidget = tester.pump();

    final eventFinder = find.byKey(const Key('event'));
    final String event = eventSelected ?? 'Event 1';

    expect(eventFinder, findsOneWidget);
    await tester.ensureVisible(eventFinder);
    await tester.tap(eventFinder);
    await pumpWidget;

    await tester.tap(find.text(event).last);
    await pumpWidget;
  }
}
