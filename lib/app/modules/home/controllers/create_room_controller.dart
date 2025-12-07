import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/room_model.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class CreateRoomController extends AppController {
  final _roomService = getIt<RoomService>();

  final name = signal('');

  final maxParticipants = signal(10);

  final isPublic = signal(true);

  Future<RoomModel?> createRoom() async {
    final result = await _roomService.createRoom(
      name.value,
      maxParticipants: maxParticipants.value,
      isPublic: isPublic.value,
    );

    switch (result) {
      case Sucess(data: final room):
        return room;
      case Failure():
        return null;
    }
  }

  @override
  void dispose() {
    name.dispose();
    maxParticipants.dispose();
    isPublic.dispose();
  }
}
