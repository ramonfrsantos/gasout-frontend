import 'app_config.dart';

mixin Environment {
  static final dev = AppConfig(
    appName: '[DEV] GasOut',
    appEnvironment: AppEnvironment.development,
    apiBaseUrl: 'http://ec2-54-82-9-178.compute-1.amazonaws.com:8008/',
  );

  static final prod = AppConfig(
    appName: '[PROD] GasOut',
    appEnvironment: AppEnvironment.production,
    apiBaseUrl: '',
  );
}
