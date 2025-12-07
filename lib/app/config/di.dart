import 'package:get_it/get_it.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/services/auth_service.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/services/user_service.dart';
import 'package:roomy/app/modules/auth/controllers/login_controller.dart';
import 'package:roomy/app/modules/auth/controllers/register_controller.dart';
import 'package:roomy/app/modules/home/controllers/create_room_controller.dart';
import 'package:roomy/app/modules/home/controllers/home_controller.dart';
import 'package:roomy/app/modules/profile/controllers/profile_controller.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<ApiService>(() async => ApiService.create());

  getIt.registerSingletonAsync<AuthService>(
    () async => AuthService.create(),
    dependsOn: [ApiService],
  );

  getIt.registerSingletonWithDependencies(
    () => UserService(),
    dependsOn: [ApiService],
  );

  getIt.registerSingletonWithDependencies<RoomService>(
    () => RoomService(),
    dependsOn: [ApiService],
  );

  getIt.registerFactory<HomeController>(() => HomeController());
  getIt.registerFactory<LoginController>(() => LoginController());
  getIt.registerFactory<RegisterController>(() => RegisterController());
  getIt.registerFactory<ProfileController>(() => ProfileController());
  getIt.registerFactory<CreateRoomController>(() => CreateRoomController());

  await getIt.allReady();
}
