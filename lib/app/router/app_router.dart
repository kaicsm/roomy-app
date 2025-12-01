import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/modules/auth/views/login_view.dart';
import 'package:roomy/app/modules/auth/views/register_view.dart';
import 'package:roomy/app/modules/home/views/home_view.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:roomy/app/router/middlewares/auth_middleware.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) => HomeView(),
        redirect: AuthMiddleware.redirect,
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) => LoginView(),
      ),

      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) => RegisterView(),
      ),
    ],
  );
}
