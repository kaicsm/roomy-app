import 'package:get_it/get_it.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/services/storage_service.dart';
import 'package:roomy/app/core/services/user_service.dart';
import 'package:roomy/app/core/services/web_socket_service.dart';
import 'package:roomy/app/modules/auth/controllers/login_controller.dart';
import 'package:roomy/app/modules/auth/controllers/signup_controller.dart';
import 'package:roomy/app/modules/home/controllers/home_controller.dart';
import 'package:roomy/app/modules/home/controllers/select_platform_controller.dart';
import 'package:roomy/app/modules/profile/controllers/profile_controller.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<StorageService>(
    () async => await StorageService.create(),
  );

  getIt.registerSingletonAsync<ApiService>(
    () async => await ApiService.create(),
    dependsOn: [StorageService],
  );

  getIt.registerSingletonAsync<AuthService>(
    () async => await AuthService.create(),
    dependsOn: [ApiService],
  );

  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerLazySingleton<RoomService>(() => RoomService());
  getIt.registerLazySingleton<WebSocketService>(() => WebSocketService());

  getIt.registerFactory<HomeController>(() => HomeController());
  getIt.registerFactory<LoginController>(() => LoginController());
  getIt.registerFactory<SignupController>(() => SignupController());
  getIt.registerFactory<ProfileController>(() => ProfileController());
  getIt.registerFactory<SelectPlatformController>(
    () => SelectPlatformController(),
  );

  await getIt.isReady<StorageService>();
  await getIt.isReady<ApiService>();
  await getIt.isReady<AuthService>();
}
