import 'package:exam1/presentation/pages/diary_form/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('location widget ...', (tester) async {
    String location = 'Sample Location';

    await tester.pumpWidget(
      MaterialApp(
        home: LocationWidget(location: location),
      ),
    );

    expect(find.byIcon(Icons.location_on), findsOneWidget);
    expect(find.text('Sample Location'), findsOneWidget);
  });
}
