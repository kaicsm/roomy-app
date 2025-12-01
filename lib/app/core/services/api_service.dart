import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:roomy/app/config/api_config.dart';

class ApiService {
  final _cookieJar = CookieJar();
  CookieJar get cookieJar => _cookieJar;

  late final Dio _client;
  Dio get client => _client;

  ApiService() {
    _client = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _client.interceptors.add(CookieManager(_cookieJar));
  }
}
