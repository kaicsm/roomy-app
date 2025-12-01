import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/api_service.dart';

class AuthService {
  final _log = Logger();

  final _apiService = getIt<ApiService>();

  Future<bool> login(String username, String password) async {
    try {
      final response = await _apiService.client.post(
        '${ApiConfig.authEndpoint}/login',
        data: {"username": username, "password": password},
      );

      if (response.statusCode! >= 400) {
        return false;
      }

      _log.i(response);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      final response = await _apiService.client.post(
        '${ApiConfig.authEndpoint}/register',
        data: {"username": username, "email": email, "password": password},
      );

      if (response.statusCode! >= 400) {
        return false;
      }

      _log.i(response);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final response = await _apiService.client.post(
      '${ApiConfig.authEndpoint}/logout',
    );

    _log.i(response);
  }

  Future<bool> isAuthenticated() async {
    try {
      final response = await _apiService.client.get(
        '${ApiConfig.userEndpoint}/me',
      );

      if (response.statusCode! >= 400) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
