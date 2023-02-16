import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await integrationDriver();

  await Process.run(
    'xcrun',
    [
      'simctl',
      'privacy',
      'booted',
      'grant',
      'all',
      'com.example.exam1',
    ],
  );
}
