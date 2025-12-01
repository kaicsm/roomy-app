import 'package:get_it/get_it.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/services/storage_service.dart';
import 'package:roomy/app/modules/auth/controllers/login_controller.dart';
import 'package:roomy/app/modules/auth/controllers/register_controller.dart';
import 'package:roomy/app/modules/home/controllers/home_controller.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingletonAsync<StorageService>(
    () async => await StorageService.create(),
  );
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  getIt.registerFactory<HomeController>(() => HomeController());
  getIt.registerFactory<LoginController>(() => LoginController());
  getIt.registerFactory<RegisterController>(() => RegisterController());
}
