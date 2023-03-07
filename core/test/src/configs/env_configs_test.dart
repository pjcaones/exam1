import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(
    () {
      EnvConfig.initialize(
        env: Environment.dev,
        apiUrl: 'https://reqres.in/',
      );
    },
  );

  test('environment should be same as in initialized', () {
    expect(EnvConfig.instance.env, Environment.dev);
  });

  test('api url should be same as in initialized', () {
    expect(EnvConfig.instance.apiUrl, 'https://reqres.in/');
  });

  test('should determine correct environment', () {
    expect(EnvConfig.isDev(), true);
    expect(EnvConfig.isStaging(), false);
    expect(EnvConfig.isProduction(), false);
  });
}
