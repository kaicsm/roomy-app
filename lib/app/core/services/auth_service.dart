import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/services/storage_service.dart';

class AuthService {
  final _log = Logger();

  final _apiService = getIt<ApiService>();
  final _storageService = getIt<StorageService>();

  Future<void> login(String username, String password) async {
    final response = await _apiService.client.post(
      '${ApiConfig.authEndpoint}/login',
      data: {"username": username, "password": password},
    );

    _saveAuthCookie();
    _log.i(response);
  }

  Future<void> register(String username, String email, String password) async {
    final response = await _apiService.client.post(
      '${ApiConfig.authEndpoint}/register',
      data: {"username": username, "email": email, "password": password},
    );

    _saveAuthCookie();
    _log.i(response);
  }

  Future<void> logout() async {
    final response = await _apiService.client.post(
      '${ApiConfig.authEndpoint}/logout',
    );

    _removeAuthCookie();
    _log.i(response);
  }

  Future<bool> isAuthenticated() async {
    final response = await _apiService.client.get(
      '${ApiConfig.userEndpoint}/me',
    );

    if (response.statusCode! >= 400) {
      return false;
    }

    return true;
  }

  Future<void> _saveAuthCookie() async {
    final cookies = await _apiService.cookieJar.loadForRequest(
      Uri.parse(ApiConfig.baseUrl),
    );

    for (var cookie in cookies) {
      if (cookie.name == "authToken") {
        await _storageService.persist("authToken", cookie.toString());
        return;
      }
    }
  }

  Future<void> _removeAuthCookie() async {
    await _storageService.remove("authToken");
  }
}
