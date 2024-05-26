import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

const _baseUrl = "baseUrl";
const _apiUrl = "apiUrl";

enum Environment { test, moderator, production }

const _defaultEnvironment = String.fromEnvironment("env", defaultValue: "test");

const currentEnvironment = _defaultEnvironment == "prod"
    ? Environment.production
    : _defaultEnvironment == "test"
        ? Environment.test
        : Environment.moderator;

var forceRefreshConfig = false;

Map<String, dynamic> _config = getConfig(currentEnvironment);

GetIt getIt = GetIt.instance;

void setEnvironment(Environment env) {
  forceRefreshConfig = true;
  _config = getConfig(env);
  final dio = getIt.get<Dio>();
  dio.options.baseUrl = baseUrl;
}

Map<String, dynamic> getConfig(Environment env) {
  switch (env) {
    case Environment.test:
      return testConfig;
    case Environment.moderator:
      return moderatorConfig;
    case Environment.production:
      return productionConfig;
  }
}

bool shouldForceRefreshConfig() {
  if (forceRefreshConfig) {
    forceRefreshConfig = false;
    return true;
  }
  return false;
}

dynamic get baseUrl {
  return _config[_baseUrl];
}

dynamic get apiUrl {
  return _config[_apiUrl];
}

Map<String, dynamic> testConfig = {
  _apiUrl: "https://api.phluid.dev",
  _baseUrl: "https://api.phluid.dev/v1",
};

Map<String, dynamic> moderatorConfig = {
  _apiUrl: "https://api.phluid.dev",
  _baseUrl: "https://api.phluid.dev/v1",
};

Map<String, dynamic> productionConfig = {
  _apiUrl: "https://api.phluid.dev",
  _baseUrl: "https://api.app.phluid.world/v1",
};
