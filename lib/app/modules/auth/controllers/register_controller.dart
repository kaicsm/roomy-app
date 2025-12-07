import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class RegisterController extends AppController {
  final _authService = getIt<AuthService>();

  final username = signal('');
  final email = signal('');
  final password = signal('');

  final errorMessage = signal<String?>(null);
  final isLoading = signal(false);

  final obscurePassword = signal(true);

  late final isValid = computed<bool>(
    () =>
        (username.value.isNotEmpty && username.value.length >= 3) &&
        (password.value.isNotEmpty && password.value.length >= 5) &&
        (email.value.isNotEmpty &&
            email.value.contains('@') &&
            email.value.length >= 4),
  );

  Future<bool> register() async {
    isLoading.value = true;

    if (!isValid.value) {
      isLoading.value = false;
      errorMessage.value = "Invalid information";
      return false;
    }

    final result = await _authService.register(
      username.value,
      email.value,
      password.value,
    );

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

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();
    errorMessage.dispose();
    obscurePassword.dispose();
  }
}
