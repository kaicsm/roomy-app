import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class AuthService {
  final _log = Logger();

  late final ApiService _apiService;

  late final Signal<bool> _isLogged;
  Signal<bool> get isLogged => _isLogged;

  AuthService._(this._apiService, this._isLogged);

  static Future<AuthService> create() async {
    final apiService = getIt<ApiService>();
    late final Signal<bool> isLogged;

    try {
      await apiService.client.get('${ApiConfig.userEndpoint}/me');
      isLogged = signal(true);
    } catch (e) {
      isLogged = signal(false);
    }

    return AuthService._(apiService, isLogged);
  }

  Future<Result<bool>> login(String username, String password) async {
    try {
      final response = await _apiService.client.post(
        '${ApiConfig.authEndpoint}/login',
        data: {"username": username, "password": password},
      );

      _isLogged.value = true;
      _log.i(response);

      return Sucess(true);
    } on DioException catch (e) {
      final errorMessage = e.response?.data ?? "Server error";
      return Failure(errorMessage);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<bool>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.client.post(
        '${ApiConfig.authEndpoint}/register',
        data: {"username": username, "email": email, "password": password},
      );

      _isLogged.value = true;
      _log.i(response);
      return Sucess(true);
    } on DioException catch (e) {
      final errorMessage = e.response?.data ?? "Server error";
      return Failure(errorMessage);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<void> logout() async {
    final response = await _apiService.client.post(
      '${ApiConfig.authEndpoint}/logout',
    );

    _isLogged.value = false;
    _log.i(response);
  }
}
