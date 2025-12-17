import 'dart:convert';

import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/user_model.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/services/storage_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';

class ProfileController extends AppController {
  final _authService = getIt<AuthService>();
  final _storageService = getIt<StorageService>();

  late final UserModel user;

  @override
  Future<void> init() async {
    user = UserModel.fromJson(jsonDecode(_storageService.getString('user')!));
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
