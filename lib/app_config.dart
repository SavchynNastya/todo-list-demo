enum Configs {
  dev,
}

abstract class AppConfig {
  AppConfig._({
    required this.apiHostName,
    required this.isProductionEnvironment,
    required this.todoistApiKey,
  });

  final String apiHostName;
  final bool isProductionEnvironment;
  final String todoistApiKey;

  String get api => 'https://$apiHostName';

  static AppConfig get init => _getForFlavor;

  static AppConfig get _getForFlavor {
    Configs flavor = Configs.values.firstWhere(
          (e) =>
      e.toString() ==
          "Configs.${const String.fromEnvironment('envFlavour', defaultValue: 'dev')}",
    );

    switch (flavor) {
      case Configs.dev:
        return DevConfig();
      default:
        throw UnimplementedError();
    }
  }
}

class DevConfig extends AppConfig {
  DevConfig()
      : super._(
    apiHostName: 'api.todoist.com',
    isProductionEnvironment: false,
    todoistApiKey: '39193ac1777f3665aa88fb5a9e6cae2d0a65fee1',
  );
}
