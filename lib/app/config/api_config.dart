import 'package:flutter/foundation.dart';
import 'package:roomy/app/config/env_config.dart';

abstract class ApiConfig {
  static String version = 'v1';

  static String baseUrl = kDebugMode
      ? '${EnvConfig.serverUrlDebug}/$version'
      : '${EnvConfig.serverUrl}/$version';

  static String authEndpoint = '/auth';
  static String roomEndpoint = '/rooms';
  static String userEndpoint = '/users';
}
