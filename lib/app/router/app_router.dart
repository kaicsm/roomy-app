import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/modules/auth/views/login_view.dart';
import 'package:roomy/app/modules/auth/views/signup_view.dart';
import 'package:roomy/app/modules/home/views/home_view.dart';
import 'package:roomy/app/modules/home/views/platform_webview_view.dart';
import 'package:roomy/app/modules/home/views/select_platform_view.dart';
import 'package:roomy/app/modules/profile/views/profile_view.dart';
import 'package:roomy/app/modules/room/views/room_view.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:roomy/app/router/middlewares/auth_middleware.dart';

class AppRouter {
  static final router = GoRouter(
    refreshListenable: getIt<AuthService>().isAuthenticated as Listenable,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomeView(),
        redirect: AuthMiddleware.redirect,
      ),

      GoRoute(path: AppRoutes.login, builder: (context, state) => LoginView()),

      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => SignupView(),
      ),

      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => ProfileView(),
        redirect: AuthMiddleware.redirect,
      ),

      GoRoute(
        path: AppRoutes.selectPlatform,
        redirect: AuthMiddleware.redirect,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: SelectPlatformView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final tween = Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.fastOutSlowIn));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          );
        },
      ),

      GoRoute(
        path: AppRoutes.platformWebview,
        builder: (context, state) {
          final platform = state.pathParameters["platform"]!;
          return PlatformWebviewView(platform);
        },
        redirect: AuthMiddleware.redirect,
      ),

      GoRoute(
        path: AppRoutes.room,
        builder: (context, status) {
          final id = status.pathParameters["id"]!;
          return RoomView(id);
        },
      ),
    ],
  );
}
