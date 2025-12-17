import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get serverDebugUrl => dotenv.get('SERVER_DEBUG_URL');
  static String get serverUrl => dotenv.get('SERVER_URL');
}
