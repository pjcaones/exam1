import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DetailsScreenRobot {
  const DetailsScreenRobot(this.tester);

  final WidgetTester tester;
  Future<void> selectArea({String? areaSelected}) async {
    final areaFinder = find.byKey(const Key('area'));
    final String area = areaSelected ?? 'Area 1';

    expect(areaFinder, findsOneWidget);
    await tester.ensureVisible(areaFinder);
    await tester.tap(areaFinder);
    await tester.pump();

    await tester.tap(find.text(area).last);
    await tester.pump();
  }

  Future<void> selectCategory({String? categorySelected}) async {
    final categoryFinder = find.byKey(const Key('category'));
    final String category = categorySelected ?? 'Task Category 1';

    expect(categoryFinder, findsOneWidget);
    await tester.ensureVisible(categoryFinder);
    await tester.tap(categoryFinder);
    await tester.pump();

    await tester.tap(find.text(category).last);
    await tester.pump();
  }

  Future<void> inputTags({String? tagInput}) async {
    final textFieldFinder = find.byKey(const Key('tag'));
    final String tag = tagInput ?? 'Sample Text';

    expect(textFieldFinder, findsOneWidget);
    await tester.tap(textFieldFinder);
    await tester.pump();

    await tester.enterText(textFieldFinder, tag);
    await tester.pumpAndSettle();
  }

  Future<void> scrollPage({bool scrollDown = false}) async {
    final scrollViewFinder = find.byType(SingleChildScrollView);
    expect(scrollViewFinder, findsOneWidget);

    if (scrollDown) {
      await tester.fling(scrollViewFinder, const Offset(0, 200), 10000);
      await tester.pumpAndSettle();
      expect(find.text('Task Category'), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -200), 10000);
      await tester.pumpAndSettle();
      expect(find.text('Add to site diary'), findsOneWidget);
    }
  }
}
