import 'package:exam1/features/diary/widgets/widgets.dart';
import 'package:exam1/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('location widget ...', (tester) async {
    const String location = 'Sample Location';

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const LocationWidget(location: location),
      ),
    );

    expect(find.byIcon(Icons.location_on), findsOneWidget);
    expect(find.text('Sample Location'), findsOneWidget);
  });
}
