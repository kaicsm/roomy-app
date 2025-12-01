import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/router/app_routes.dart';

class AuthMiddleware {
  static Future<String?> redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final authService = getIt<AuthService>();
    final isAuthenticated = await authService.isAuthenticated();

    if (!isAuthenticated) {
      return AppRoutes.login;
    }

    return null;
  }
}
