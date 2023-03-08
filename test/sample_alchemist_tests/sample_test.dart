import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
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
      'test run for alchemist package',
      fileName: 'initial',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'initial ui',
            child: const MyTestWidget(),
          ),
          GoldenTestScenario(
            name: 'different text color',
            child: const MyTestWidget(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  });
}
