import 'package:exam1/injection_container.dart' as get_it;
import 'package:exam1/presentation/pages/diary_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  get_it.init();

  Widget widgetUnderTest() {
    return const MaterialApp(
      title: 'Exam 1',
      home: DiaryFormPage(),
    );
  }

  testWidgets('diary form page ...', (tester) async {
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
}
