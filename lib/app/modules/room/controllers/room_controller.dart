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
  final currentIsPlaying = signal(false);
  final memberCount = signal(0);

  bool _isRemoteUpdate = false;

  final connectionStatus = signal('Loading...');
  late final isLoading = computed(
    () => connectionStatus.value.toLowerCase().contains('loading...'),
  );

  late final Player player;
  late final VideoController videoController;

  WebSocketChannel? _channel;

  @override
  Future<void> init() async {
    player = Player();
    videoController = VideoController(player);

    final result = await _roomService.connectToRoom(roomId);

    switch (result) {
      case Success(data: final channel):
        _channel = channel;
        connectionStatus.set("Connected");
        _sendMessage(SyncRequestMessage());
        _listenToWebsocket();
        _setupPlayerListeners();
        break;
      case Failure(message: final error):
        connectionStatus.set('Failure: $error');
        break;
    }
  }

  void _setupPlayerListeners() {
    player.stream.playing.listen((playing) {
      if (_isRemoteUpdate) return;

      currentIsPlaying.set(playing);
      _sendPlaybackUpdate(isPlaying: currentIsPlaying.value);
    });
    player.stream.position.listen((position) {
      if (_isRemoteUpdate) return;

      final diff = (position - currentPosition.value).abs().inSeconds;
      if (diff > 2) {
        _sendPlaybackUpdate(currentTime: position.inMilliseconds.toInt());
      }
      currentPosition.set(position);
    });
  }

  void _listenToWebsocket() {
    _channel!.stream.listen((message) {
      final messageJson = jsonDecode(message);
      final wsMessage = WsIncomingMessage.fromJson(messageJson);

      _handleWsMessage(wsMessage);
    });
  }

  Future<void> _handleWsMessage(WsIncomingMessage message) async {
    switch (message) {
      case SyncFullStateMessage(payload: final state):
        _handlePlaybackUpdate(state.playbackState!);
        break;
      case PlaybackUpdatedMessage(payload: final state):
        _handlePlaybackUpdate(state);
        break;
    }
  }

  void _handlePlaybackUpdate(PlaybackStateModel state) {
    _isRemoteUpdate = true;

    final stateMediaUrl = state.mediaUrl;
    final stateCurrentTime = Duration(milliseconds: state.currentTime.toInt());
    final stateIsPlaying = state.isPlaying;

    if (stateMediaUrl != currentUrl.value) {
      currentUrl.set(state.mediaUrl);
      player.open(Media(currentUrl.value));
    }

    final diff = (stateCurrentTime - currentPosition.value).abs().inSeconds;

    if (diff > 2) {
      currentPosition.set(stateCurrentTime);
      player.seek(stateCurrentTime);
    }

    if (stateIsPlaying != currentIsPlaying.value) {
      currentIsPlaying.set(stateIsPlaying);
      stateIsPlaying ? player.play() : player.pause();
    }

    _isRemoteUpdate = false;
  }

  void _sendPlaybackUpdate({
    String? mediaUrl,
    bool? isPlaying,
    int? currentTime,
    double? playbackSpeed,
  }) {
    final payload = {
      if (mediaUrl != null) 'mediaUrl': mediaUrl,
      if (isPlaying != null) 'isPlaying': isPlaying,
      if (currentTime != null) 'currentTime': currentTime,
      if (playbackSpeed != null) 'playbackSpeed': playbackSpeed,
    };

    _sendMessage(UpdatePlaybackMessage(payload));
  }

  void _sendMessage(WsOutgoingMessage message) {
    final messageJson = message.toJson();
    _channel!.sink.add(jsonEncode(messageJson));
  }

  @override
  void dispose() {
    player.dispose();
    currentUrl.dispose();
    currentPosition.dispose();
    currentIsPlaying.dispose();
    memberCount.dispose();
    connectionStatus.dispose();
    if (_channel != null) _channel!.sink.close();
  }
}
