import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get serverUrlDebug => dotenv.get('SERVER_URL_DEBUG');
  static String get serverUrl => dotenv.get('SERVER_URL');
}
