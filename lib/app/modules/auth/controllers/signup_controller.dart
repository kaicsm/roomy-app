import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class SignupController extends AppController {
  final _authService = getIt<AuthService>();

  final username = signal('');
  final email = signal('');
  final password = signal('');

  final isLoading = signal(false);
  final errorMessage = signal<String?>(null);

  final obscurePassword = signal(true);
  final termsCheck = signal(false);
  final submitted = signal(false);

  final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  final _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  bool get isUsernameValid => _usernameRegex.hasMatch(username.value);
  bool get isEmailValid => _emailRegex.hasMatch(email.value.trim());
  bool get isPasswordValid => password.value.length >= 6;
  bool get isTermsAccepted => termsCheck.value;

  late final isValid = computed<bool>(
    () => isUsernameValid && isEmailValid && isPasswordValid && isTermsAccepted,
  );

  Future<bool> register() async {
    submitted.value = true;
    errorMessage.value = null;

    if (!isValid.value) {
      return false;
    }

    isLoading.value = true;

    final result = await _authService.register(
      username.value,
      email.value,
      password.value,
    );

    switch (result) {
      case Success():
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
    email.dispose();
    password.dispose();
    isLoading.dispose();
    errorMessage.dispose();
    obscurePassword.dispose();
    termsCheck.dispose();
    submitted.dispose();
  }
}
