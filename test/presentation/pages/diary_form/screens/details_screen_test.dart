import 'package:exam1/presentation/pages/diary_form/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  Map<int, String> _areas = {
    1: 'Area 1',
    2: 'Area 2',
    3: 'Area 3',
  };

  Map<int, String> _categories = {
    1: 'Category 1',
    2: 'Category 2',
    3: 'Category 3',
  };

  TextEditingController _diaryDateController = TextEditingController();
  int _areaID = 1;
  int _categoryID = 1;
  TextEditingController _tagsController = TextEditingController();

  Widget widgetUnderTest() {
    return MaterialApp(
      home: DetailsScreen(
          areas: _areas,
          categories: _categories,
          diaryDateController: _diaryDateController,
          areaID: _areaID,
          categoryID: _categoryID,
          tagsController: _tagsController,
          onSelectAreas: (value) {
            if (value != null) {
              _areaID = value;
            }
          },
          onSelectCategory: (value) {
            if (value != null) {
              _categoryID = value;
            }
          }),
    );
  }

  testWidgets('details screen ...', (tester) async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    int dateNow = DateTime.now().millisecondsSinceEpoch;
    String sDateNow =
        format.format(DateTime.fromMillisecondsSinceEpoch(dateNow));

    _diaryDateController.text = sDateNow;

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

    expect(_areaID, 3);
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

    expect(_categoryID, 3);
  });
}
