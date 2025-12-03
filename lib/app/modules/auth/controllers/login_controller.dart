import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class LoginController {
  final _authService = getIt<AuthService>();

  final username = signal('');
  final password = signal('');

  final isLoading = signal(false);
  final errorMessage = signal<String?>(null);

  late final isValid = computed<bool>(
    () =>
        (username.value.isNotEmpty && username.value.length >= 3) &&
        (password.value.isNotEmpty && password.value.length >= 5),
  );

  Future<bool> login() async {
    isLoading.value = true;

    if (!isValid.value) {
      isLoading.value = false;
      errorMessage.value = "Invalid information";
      return false;
    }

    final result = await _authService.login(username.value, password.value);

    switch (result) {
      case Sucess():
        isLoading.value = false;
        return true;
      case Failure(message: final msg):
        isLoading.value = false;
        errorMessage.value = msg;
        return false;
    }
  }
}
