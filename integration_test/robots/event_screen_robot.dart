import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class EventScreenRobot {
  const EventScreenRobot(this.tester);

  final WidgetTester tester;

  Future<void> selectEvent({String? eventSelected}) async {
    final eventFinder = find.byKey(const Key('event'));
    final String event = eventSelected ?? 'Event 1';

    expect(eventFinder, findsOneWidget);
    await tester.ensureVisible(eventFinder);
    await tester.tap(eventFinder);
    await tester.pump();

    await tester.tap(find.text(event).last);
    await tester.pump();
  }
}
