import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';

class ProfileController {
  final _authService = getIt<AuthService>();

  Future<void> logout() async {
    await _authService.logout();
  }
}
