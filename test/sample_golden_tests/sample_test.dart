import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

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
  Color color = Colors.red;

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
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

void main() {
  testGoldens('test run using widget builder', (tester) async {
    await tester.pumpWidgetBuilder(const MyTestWidget());

    await screenMatchesGolden(tester, 'content1');
  });

  //Test in multiple devices
  testGoldens('test run for device builder', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
          Device.tabletLandscape,
        ],
      )
      ..addScenario(
        widget: const MyTestWidget(
          color: Colors.green,
        ),
        name: 'initial load',
      )
      ..addScenario(
        widget: const MyTestWidget(
          color: Colors.green,
        ),
        name: 'pressing button',
        onCreate: (key) async {
          final finder = find.descendant(
            of: find.byKey(key),
            matching: find.byType(ElevatedButton),
          );
          expect(finder, findsOneWidget);

          await tester.tap(finder);
          await tester.pump();

          expect(
            find.descendant(
              of: find.byKey(key),
              matching: find.text('Button Pressed!'),
            ),
            findsOneWidget,
          );
        },
      );
    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'content_device_builder');
  });
}
