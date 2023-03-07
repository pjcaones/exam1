import 'package:core/core.dart';

class EnvConfig {
  final Environment env;
  final String apiUrl;

  EnvConfig._internal({
    required this.env,
    required this.apiUrl,
  });

  static late EnvConfig _instance;

  factory EnvConfig.initialize({
    required Environment env,
    required String apiUrl,
  }) {
    _instance = EnvConfig._internal(
      env: env,
      apiUrl: apiUrl,
    );

    return _instance;
  }

  static EnvConfig get instance => _instance;
  static bool isProduction() => EnvConfig.instance.env == Environment.prod;
  static bool isStaging() => EnvConfig.instance.env == Environment.staging;
  static bool isDev() => EnvConfig.instance.env == Environment.dev;
}
