import 'package:flutter/cupertino.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:signals/signals_flutter.dart';

class LoginController {
  final _authService = getIt<AuthService>();

  final username = signal('');
  final password = signal('');

  final formKey = GlobalKey();

  late final isValid = computed<bool>(
    () =>
        (username.value.isNotEmpty && username.value.length >= 3) &&
        (password.value.isNotEmpty && password.value.length >= 5),
  );

  Future<bool> login() async {
    if (!isValid.value) return false;

    return await _authService.login(username.value, password.value);
  }
}
