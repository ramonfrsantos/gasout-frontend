enum AppEnvironment {
  production,
  development,
}

class AppConfig {
  final String appName;
  final AppEnvironment appEnvironment;
  final String apiBaseUrl;

  AppConfig({
    required this.appName,
    required this.appEnvironment,
    required this.apiBaseUrl,
  });

  static AppConfig? _instance;

  static AppConfig? getInstance({AppConfig? config}) {
    if (_instance == null) {
      _instance = config;
      print('APP CONFIGURED FOR: ${config!.appName}');
      return _instance;
    }
    return _instance;
  }

  bool get isProd => (_instance!.appEnvironment == AppEnvironment.production);
}
