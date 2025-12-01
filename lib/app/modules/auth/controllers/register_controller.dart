import 'package:flutter/cupertino.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:signals/signals_flutter.dart';

class RegisterController {
  final _authService = getIt<AuthService>();

  final username = signal('');
  final email = signal('');
  final password = signal('');

  final formKey = GlobalKey();

  late final isValid = computed<bool>(
    () =>
        (username.value.isNotEmpty && username.value.length >= 3) &&
        (password.value.isNotEmpty && password.value.length >= 5) &&
        (email.value.isNotEmpty &&
            email.value.contains('@') &&
            email.value.length >= 4),
  );

  Future<void> register() async {
    if (!isValid.value) return;
    await _authService.register(username.value, email.value, password.value);
  }
}
