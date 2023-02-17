import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AddImageScreenRobot {
  const AddImageScreenRobot(this.tester);

  final WidgetTester tester;

  Future<void> removeImage() async {
    //Assuming 2 images were added
    //If more than 2 images, it will fail in line 30
    final removeFinder = find.byKey(const Key('remove_image_button_0'));
    expect(find.byIcon(Icons.close), findsAtLeastNWidgets(2));

    await tester.tap(removeFinder);

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byIcon(Icons.close), findsOneWidget);
  }
}
