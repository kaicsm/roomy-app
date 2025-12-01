import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roomy/app/config/api_config.dart';

class ApiService {
  late final PersistCookieJar _cookieJar;
  PersistCookieJar get cookieJar => _cookieJar;

  late final Dio _client;
  Dio get client => _client;

  ApiService._(this._cookieJar, this._client);

  static Future<ApiService> create() async {
    final appDocPath = await getApplicationDocumentsDirectory();
    final cookieJar = PersistCookieJar(
      storage: FileStorage('$appDocPath/.cookies'),
    );

    final client = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    client.interceptors.add(CookieManager(cookieJar));

    return ApiService._(cookieJar, client);
  }
}
