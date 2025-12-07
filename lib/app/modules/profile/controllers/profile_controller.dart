import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';

class ProfileController extends AppController {
  final _authService = getIt<AuthService>();

  Future<void> logout() async {
    await _authService.logout();
  }
}
