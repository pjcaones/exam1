import 'package:exam1/presentation/pages/diary_form/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  final Map<int, String> areas = {
    1: 'Area 1',
    2: 'Area 2',
    3: 'Area 3',
  };

  final Map<int, String> categories = {
    1: 'Category 1',
    2: 'Category 2',
    3: 'Category 3',
  };

  final TextEditingController diaryDateController = TextEditingController();
  int areaID = 1;
  int categoryID = 1;
  final TextEditingController tagsController = TextEditingController();

  Widget widgetUnderTest() {
    return MaterialApp(
      home: DetailsScreen(
          areas: areas,
          categories: categories,
          diaryDateController: diaryDateController,
          areaID: areaID,
          categoryID: categoryID,
          tagsController: tagsController,
          onSelectAreas: (value) {
            if (value != null) {
              areaID = value;
            }
          },
          onSelectCategory: (value) {
            if (value != null) {
              categoryID = value;
            }
          }),
    );
  }

  testWidgets('details screen ...', (tester) async {
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final int dateNow = DateTime.now().millisecondsSinceEpoch;
    final String sDateNow =
        format.format(DateTime.fromMillisecondsSinceEpoch(dateNow));

    diaryDateController.text = sDateNow;

    await tester.pumpWidget(widgetUnderTest());

    final inputFieldFinder = find.byKey(const Key('diary_date'));
    expect(inputFieldFinder, findsOneWidget);

    final inputFieldDiaryDate = tester.firstWidget<TextField>(inputFieldFinder);
    expect(inputFieldDiaryDate.controller?.text, sDateNow);
  });

  testWidgets('dropdown area loading..', (widgetTester) async {
    await widgetTester.pumpWidget(widgetUnderTest());

    final dropdownFinder = find.byKey(const Key('area'));
    expect(dropdownFinder, findsOneWidget);

    await widgetTester.ensureVisible(dropdownFinder);

    await widgetTester.tap(dropdownFinder);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text('Area 3').last);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(areaID, 3);
  });

  testWidgets('dropdown category loading..', (widgetTester) async {
    await widgetTester.pumpWidget(widgetUnderTest());

    final dropdownFinder = find.byKey(const Key('category'));
    expect(dropdownFinder, findsOneWidget);

    await widgetTester.ensureVisible(dropdownFinder);

    await widgetTester.tap(dropdownFinder);
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text('Category 3').last);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(categoryID, 3);
  });
}
