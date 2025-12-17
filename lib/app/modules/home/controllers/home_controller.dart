import 'dart:convert';

import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/room_model.dart';
import 'package:roomy/app/core/models/user_model.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/services/storage_service.dart';
import 'package:roomy/app/core/services/user_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class HomeController extends AppController {
  final _roomService = getIt<RoomService>();
  final _userService = getIt<UserService>();
  final _storageService = getIt<StorageService>();

  final rooms = signal<List<RoomModel>>([]);
  final search = signal('');
  final isSearching = signal(false);

  late final filteredRooms = computed(() {
    final searchTerm = search.value.toLowerCase().trim();
    if (searchTerm.isEmpty) {
      return rooms.value;
    }

    return rooms.value.where((room) {
      return room.name.toLowerCase().contains(searchTerm);
    }).toList();
  });

  late final UserModel user;

  @override
  Future<void> init() async {
    user = UserModel.fromJson(jsonDecode(_storageService.getString('user')!));
    await getPublicRooms();
  }

  @override
  void dispose() {
    rooms.dispose();
    search.dispose();
    isSearching.dispose();
  }

  Future<void> getPublicRooms() async {
    final result = await _roomService.getPublicRooms();

    switch (result) {
      case Success(data: final rooms):
        this.rooms.set(rooms);
      case Failure():
        break;
    }
  }

  Future<UserModel?> getUser(String id) async {
    final result = await _userService.getUser(id);

    switch (result) {
      case Success(data: final user):
        return user;
      case Failure():
        return null;
    }
  }

  String getWeather() {
    switch (DateTime.now().hour) {
      case < 6:
        return 'night';
      case < 12:
        return 'morning';
      case < 18:
        return 'afternoon';
      default:
        return 'evening';
    }
  }
}
