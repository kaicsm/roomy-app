import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RoomController extends AppController {
  final _roomService = getIt<RoomService>();

  final String roomId;

  final videoUrl = signal(
    'https://publicdomainmovie.net/movie.php?id=Million_Dollar_Weekend_1948&type=.mp4',
  );

  late Player player;
  late VideoController videoController;
  late WebSocketChannel _channel;

  RoomController(this.roomId);

  @override
  Future<void> init() async {
    final result = await _roomService.connectToRoom(roomId);
    switch (result) {
      case Success(data: final channel):
        _channel = channel;
        break;
      case Failure():
        break;
    }

    player = Player();
    videoController = VideoController(player);

    await player.open(Media(videoUrl.value));
  }

  @override
  void dispose() {
    player.dispose();
    _channel.sink.close();
    videoUrl.dispose();
    super.dispose();
  }
}
