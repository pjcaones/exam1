import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    await driver.close();
  });

  group('end-to-end app test', () {
    test('pick image', () async {
      // print('dadaan kaya?');

      // final buttonFinder = find.byValueKey('add_photo');
      final buttonFinder = find.text('Yehey');

      await driver.waitFor(buttonFinder);
      await driver.tap(buttonFinder);
      await Future.delayed(const Duration(seconds: 5));
    });
  });
}
