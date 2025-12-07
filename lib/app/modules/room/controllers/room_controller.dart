import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RoomController extends AppController {
  final _roomService = getIt<RoomService>();

  final isPlayerReady = signal(false);

  String? _currentRoomId;
  String? get currentRoomId => _currentRoomId;

  final videoUrl = signal(
    'https://publicdomainmovie.net/movie.php?id=Million_Dollar_Weekend_1948&type=.mp4',
  );

  late Player player;
  late VideoController videoController;
  late WebSocketChannel _channel;

  Future<void> initialize(String roomId) async {
    if (_currentRoomId == roomId && isPlayerReady.value) return;

    isPlayerReady.value = false;
    _currentRoomId = roomId;

    final result = await _roomService.getWebSocketChannel(roomId);
    switch (result) {
      case Sucess(data: final channel):
        _channel = channel;
        break;
      case Failure():
        break;
    }

    player = Player();
    videoController = VideoController(player);

    await player.open(Media(videoUrl.value));

    isPlayerReady.value = true;
  }

  @override
  void dispose() {
    if (isPlayerReady.value) {
      player.dispose();
      _channel.sink.close();
    }
    videoUrl.dispose();
    isPlayerReady.dispose();
    _currentRoomId = null;
    super.dispose();
  }
}
