import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/user_model.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/services/storage_service.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class AuthService {
  final _log = Logger();

  late final ApiService _apiService;
  late final StorageService _storageService;

  late final Signal<bool> _isAuthenticated;
  Signal<bool> get isAuthenticated => _isAuthenticated;

  AuthService._(this._apiService, this._storageService, this._isAuthenticated);

  static Future<AuthService> create() async {
    final apiService = getIt<ApiService>();
    final storageService = getIt<StorageService>();

    bool isAuthenticated = false;

    try {
      final response = await apiService.client.get(
        '${ApiConfig.userEndpoint}/me',
      );

      final user = UserModel.fromJson(response.data);
      storageService.setString('user', jsonEncode(user.toJson()));

      isAuthenticated = true;
    } catch (e) {
      isAuthenticated = false;
    }

    return AuthService._(apiService, storageService, signal(isAuthenticated));
  }

  Future<Result<UserModel>> login(String username, String password) async {
    try {
      final response = await _apiService.client.post(
        '${ApiConfig.authEndpoint}/login',
        data: {"username": username, "password": password},
      );

      final user = UserModel.fromJson(response.data);
      _storageService.setString('user', jsonEncode(user.toJson()));

      _log.i(user.toString());
      _isAuthenticated.value = true;

      return Success(user);
    } on DioException catch (e) {
      _log.e(e.toString());
      final errorMessage = e.response?.data ?? "Server error";
      return Failure(errorMessage);
    } catch (e) {
      _log.e(e.toString());
      return Failure(e.toString());
    }
  }

  Future<Result<UserModel>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await _apiService.client.post(
        '${ApiConfig.authEndpoint}/register',
        data: {"username": username, "email": email, "password": password},
      );

      final user = UserModel.fromJson(response.data);
      _storageService.setString('user', jsonEncode(user.toJson()));

      _log.i(user.toString());
      _isAuthenticated.value = true;

      return Success(user);
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

    _apiService.cookieJar.deleteAll();
    _storageService.remove('user');

    _isAuthenticated.value = false;
    _log.i(response);
  }
}
