import 'app_config.dart';

mixin Environment {
  static final dev = AppConfig(
    appName: '[DEV] GasOut',
    appEnvironment: AppEnvironment.development,
    apiBaseUrl: 'http://10.0.2.2:8089/',
  );

  static final prod = AppConfig(
    appName: '[PROD] GasOut',
    appEnvironment: AppEnvironment.production,
    apiBaseUrl: 'http://52.90.91.238:8080/',
  );
}
