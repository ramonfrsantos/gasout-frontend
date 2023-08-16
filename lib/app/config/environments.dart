import 'app_config.dart';

mixin Environment {
  static final dev = AppConfig(
    appName: '[DEV] GasOut',
    appEnvironment: AppEnvironment.development,
    apiBaseUrl: 'http://54.204.70.224:8080/',
  );

  static final prod = AppConfig(
    appName: '[PROD] GasOut',
    appEnvironment: AppEnvironment.production,
    apiBaseUrl: 'http://54.204.70.224:8080/',
  );
}
