import 'dart:io';

import 'package:exam1/main.dart' as app;
import 'package:flutter/services.dart';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  enableFlutterDriverExtension();

  // await Process.run(
  //   'xcrun',
  //   [
  //     'simctl',
  //     'privacy',
  //     'booted',
  //     'grant',
  //     'all',
  //     'com.example.exam1',
  //   ],
  // );

  // print('dumaan naman dito..');

  const MethodChannel('plugins.flutter.io/image_picker')
      .setMockMethodCallHandler((call) async {
    // print("dumaan na dito!");
    return null;
  });

  app.main();
}
