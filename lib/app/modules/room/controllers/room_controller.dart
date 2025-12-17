import 'dart:async';
import 'dart:convert';

import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/playback_state_model.dart';
import 'package:roomy/app/core/models/ws_message_model.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RoomController extends AppController {
  final _roomService = getIt<RoomService>();

  final String roomId;

  RoomController(this.roomId);

  final currentUrl = signal('');
  final currentPosition = signal(Duration.zero);
  final currentIsPlaying = signal(true);
  final memberCount = signal(0);

  final connectionStatus = signal('Loading...');
  late final isLoading = computed(
    () => connectionStatus.value.toLowerCase().contains('loading...'),
  );

  final List<StreamSubscription> _subscriptions = [];
  Timer? _heartbeatTimer;

  late final Player player;
  late final VideoController videoController;

  WebSocketChannel? _channel;

  @override
  Future<void> init() async {
    player = Player();
    videoController = VideoController(player);

    final result = await _roomService.connectToRoom(roomId);

    _setupPlayerListeners();

    switch (result) {
      case Success(data: final channel):
        _channel = channel;
        connectionStatus.set("Connected");
        _listenToWebsocket();
        _sendMessage(SyncRequestMessage());
        _startHeartbeat();
        break;
      case Failure(message: final error):
        connectionStatus.set('Failure: $error');
        break;
    }
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

  void _startHeartbeat() {
    _heartbeatTimer = Timer.periodic(
      Duration(seconds: 30),
      (_) => _sendMessage(HeartbeatMessage()),
    );
  }

  void _listenToWebsocket() {
    _subscriptions.add(
      _channel!.stream.listen((message) async {
        final messageJson = jsonDecode(message);
        final wsMessage = WsIncomingMessage.fromJson(messageJson);

        await _handleWsMessage(wsMessage);
      }),
    );
  }

  Future<void> _handleWsMessage(WsIncomingMessage message) async {
    switch (message) {
      case SyncFullStateMessage(payload: final state):
        await _handlePlaybackUpdate(state.playbackState!);
        break;
      case PlaybackUpdatedMessage(payload: final state):
        await _handlePlaybackUpdate(state);
        break;
      case UserJoinedMessage(memberCount: final memberCount):
        _handleUserJoined(memberCount);
        break;
      case UserLeftMessage(memberCount: final memberCount):
        _handleUserLeft(memberCount);
        break;
    }
  }

  Future<void> _handlePlaybackUpdate(PlaybackStateModel state) async {
    final stateMediaUrl = state.mediaUrl;
    final stateCurrentTime = Duration(milliseconds: state.currentTime);
    final stateIsPlaying = state.isPlaying;

    if (stateMediaUrl != currentUrl.value) {
      currentUrl.set(state.mediaUrl);
      await player.open(Media(currentUrl.value));
      await _waitForPlayerReady();
    }

    await player.seek(stateCurrentTime);

    if (stateIsPlaying) {
      await player.play();
    } else {
      await player.pause();
    }
  }

  void _handleUserJoined(int memberCount) {
    this.memberCount.set(memberCount);
  }

  void _handleUserLeft(int memberCount) {
    this.memberCount.set(memberCount);
  }

  void _sendPlaybackUpdate({
    String? mediaUrl,
    bool? isPlaying,
    int? currentTime,
    double? playbackSpeed,
  }) {
    final payload = {
      if (mediaUrl != null) 'mediaUrl': mediaUrl,
      'isPlaying': isPlaying ?? currentIsPlaying.value,
      if (currentTime != null) 'currentTime': currentTime,
      if (playbackSpeed != null) 'playbackSpeed': playbackSpeed,
    };

    _sendMessage(UpdatePlaybackMessage(payload));
  }

  void _sendMessage(WsOutgoingMessage message) {
    final messageJson = message.toJson();
    _channel!.sink.add(jsonEncode(messageJson));
  }

  Future<void> onPlayPause() async {
    await player.playOrPause();

    final isPlaying = player.state.playing;
    _sendPlaybackUpdate(isPlaying: isPlaying);
  }

  Future<void> onSeek(Duration position) async {
    await player.seek(position);
    _sendPlaybackUpdate(currentTime: position.inMilliseconds);
  }

  Future<void> _waitForPlayerReady() async {
    final completer = Completer<void>();
    StreamSubscription? bufferingSubscription;

    bufferingSubscription = player.stream.buffering.listen((isBuffering) {
      if (!isBuffering && !completer.isCompleted) {
        bufferingSubscription?.cancel();
        completer.complete();
      }
    });

    return completer.future;
  }

  @override
  void dispose() {
    _heartbeatTimer?.cancel();

    for (final s in _subscriptions) {
      s.cancel();
    }
    _subscriptions.clear();

    player.dispose();
    currentUrl.dispose();
    currentPosition.dispose();
    currentIsPlaying.dispose();
    memberCount.dispose();
    connectionStatus.dispose();
    if (_channel != null) _channel!.sink.close();
  }
}
