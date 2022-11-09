import 'app_config.dart';

mixin Environment {
  static final dev = AppConfig(
    appName: '[DEV] GasOut',
    appEnvironment: AppEnvironment.development,
    apiBaseUrl: 'http://34.201.149.55:8888/',
  );

  static final prod = AppConfig(
    appName: '[PROD] GasOut',
    appEnvironment: AppEnvironment.production,
    apiBaseUrl: '',
  );
}
