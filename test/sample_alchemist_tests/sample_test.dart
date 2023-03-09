import 'package:alchemist/alchemist.dart';
import 'package:exam1/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

class MyTestWidget extends StatefulWidget {
  const MyTestWidget({
    super.key,
    this.color = Colors.red,
  });
  final Color? color;

  @override
  State<MyTestWidget> createState() => _MyTestWidgetState();
}

class _MyTestWidgetState extends State<MyTestWidget> {
  String? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              content = 'Button Pressed!';
            });
          },
          child: const Text('Click me!'),
        ),
        Text(
          content ?? 'No Content',
          style: TextStyle(
            color: widget.color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

void main() {
  group('test for alchemist package', () {
    goldenTest(
      'renders correctly',
      fileName: 'initial',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'initial ui',
            child: const MyTestWidget(),
          ),
          GoldenTestScenario(
            name: 'with green text color',
            child: const MyTestWidget(
              color: Colors.green,
            ),
          ),
          GoldenTestScenario(
            name: 'with blue text color',
            child: const MyTestWidget(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'test for button pressed',
      fileName: 'button_pressed',
      pumpBeforeTest: (tester) async {
        final finder = find.byType(ElevatedButton);

        expect(finder, findsOneWidget);
        await tester.tap(finder);
      },
      builder: () => GoldenTestScenario(
        name: 'changed text after button pressed',
        child: const MyTestWidget(),
      ),
    );

    goldenTest(
      'test for material app',
      fileName: 'material_app',
      pumpWidget: (tester, widget) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'My Test Widget',
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: widget,
          ),
        );
      },
      builder: () => GoldenTestScenario(
        name: 'using material app',
        child: const MyTestWidget(),
      ),
    );
  });
}
