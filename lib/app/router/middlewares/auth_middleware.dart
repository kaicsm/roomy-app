import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/router/app_routes.dart';

class AuthMiddleware {
  static String? redirect(BuildContext context, GoRouterState state) {
    final authService = getIt<AuthService>();
    final isLogged = authService.isLogged;

    if (!isLogged.value) {
      return AppRoutes.login;
    }

    return null;
  }
}
