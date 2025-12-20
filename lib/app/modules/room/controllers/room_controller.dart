import 'dart:async';

import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/playback_state_model.dart';
import 'package:roomy/app/core/models/ws_message_model.dart';
import 'package:roomy/app/core/services/web_socket_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:signals/signals_flutter.dart';

class RoomController extends AppController {
  late final WebSocketService _webSocketService;
  final String roomId;

  late final Player player;
  late final VideoController videoController;

  final currentPosition = signal(Duration.zero);
  final currentIsPlaying = signal(false);
  final currentUrl = signal('');

  final memberCount = signal(0);

  late final Signal<ConnectionStatus> connectionStatus;

  final List<StreamSubscription> _subscriptions = [];

  RoomController(this.roomId);

  @override
  Future<void> init() async {
    _webSocketService = getIt<WebSocketService>();
    connectionStatus = _webSocketService.connectionStatus;

    player = Player();
    videoController = VideoController(player);

    await _webSocketService.connect(roomId);

    _subscriptions.add(_webSocketService.messages.listen(_handleMessage));

    _setupPlayerListeners();

    _webSocketService.requestSync();
  }

  void _setupPlayerListeners() {
    _subscriptions.add(
      player.stream.position.listen((position) {
        currentPosition.set(position);
      }),
    );
    _subscriptions.add(
      player.stream.playing.listen((isPlaying) {
        currentIsPlaying.set(isPlaying);
      }),
    );
  }

  Future<void> _handleMessage(WsIncomingMessage message) async {
    switch (message) {
      case SyncFullStateMessage(payload: final state):
        await _syncPlayback(state.playbackState!);
        memberCount.set(state.members.length);
        break;

      case PlaybackUpdatedMessage(payload: final state):
        await _syncPlayback(state);
        break;

      case UserJoinedMessage(memberCount: final count):
        memberCount.set(count);
        break;

      case UserLeftMessage(memberCount: final count):
        memberCount.set(count);
        break;

      default:
        break;
    }
  }

  Future<void> _syncPlayback(PlaybackStateModel state) async {
    if (state.mediaUrl != currentUrl.value) {
      currentUrl.set(state.mediaUrl);
      await player.open(Media(currentUrl.value));
      await _waitForPlayerReady();
    }

    await player.seek(Duration(milliseconds: state.currentTime));

    if (state.isPlaying) {
      await player.play();
    } else {
      await player.pause();
    }
  }

  Future<void> onPlayPause() async {
    await player.playOrPause();

    _webSocketService.sendPlaybackUpdate(isPlaying: player.state.playing);
  }

  Future<void> onSeek(Duration position) async {
    await player.seek(position);

    _webSocketService.sendPlaybackUpdate(currentTime: position.inMilliseconds);
  }

  Future<void> _waitForPlayerReady() async {
    final completer = Completer<void>();
    StreamSubscription? sub;

    sub = player.stream.buffering.listen((buffering) {
      if (!buffering && !completer.isCompleted) {
        sub?.cancel();
        completer.complete();
      }
    });

    return completer.future;
  }

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _webSocketService.dispose();
    player.dispose();
    currentUrl.dispose();
    currentPosition.dispose();
    currentIsPlaying.dispose();
    memberCount.dispose();
  }
}
