import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/utils/signal_notifier.dart';
import 'package:roomy/app/modules/auth/views/login_view.dart';
import 'package:roomy/app/modules/auth/views/register_view.dart';
import 'package:roomy/app/modules/home/views/home_view.dart';
import 'package:roomy/app/modules/profile/views/profile_view.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:roomy/app/router/middlewares/auth_middleware.dart';

class AppRouter {
  static final router = GoRouter(
    refreshListenable: SignalNotifier(getIt<AuthService>().isLogged),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomeView(),
        redirect: AuthMiddleware.redirect,
      ),

      GoRoute(path: AppRoutes.login, builder: (context, state) => LoginView()),

      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => RegisterView(),
      ),

      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => ProfileView(),
        redirect: AuthMiddleware.redirect,
      ),
    ],
  );
}
