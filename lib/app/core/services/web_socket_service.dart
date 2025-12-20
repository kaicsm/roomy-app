import 'dart:async';
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/ws_message_model.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:signals/signals_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ConnectionStatus { disconnected, connecting, connected, error }

class WebSocketService {
  final _apiService = getIt<ApiService>();
  final _log = Logger();

  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  final List<StreamSubscription> _subscriptions = [];

  final connectionStatus = signal<ConnectionStatus>(
    ConnectionStatus.disconnected,
  );

  final _messageController = StreamController<WsIncomingMessage>.broadcast();
  Stream<WsIncomingMessage> get messages => _messageController.stream;

  Future<bool> connect(String roomId) async {
    try {
      connectionStatus.value = ConnectionStatus.connecting;

      final authCookie = (await _apiService.cookieJar.loadForRequest(
        Uri.parse(ApiConfig.baseUrl),
      )).firstWhere((cookie) => cookie.name == 'authToken').value;

      final url = _buildWebSocketUrl(roomId, authCookie);

      _channel = WebSocketChannel.connect(Uri.parse(url));
      await _channel!.ready;

      _listenToMessages();
      _startHeartbeat();

      connectionStatus.value = ConnectionStatus.connected;
      return true;
    } catch (e) {
      _log.e('WebSocket connection failed', error: e);
      connectionStatus.value = ConnectionStatus.error;
      return false;
    }
  }

  void _listenToMessages() {
    _subscriptions.add(
      _channel!.stream.listen(
        (message) {
          try {
            final messageJson = jsonDecode(message);
            final wsMessage = WsIncomingMessage.fromJson(messageJson);
            _messageController.add(wsMessage);
          } catch (e) {
            _log.e('Failed to parse message', error: e);
          }
        },
        onError: (error) {
          _log.e('WebSocket error', error: error);
          connectionStatus.value = ConnectionStatus.error;
        },
        onDone: () {
          _log.i('WebSocket closed');
          connectionStatus.value = ConnectionStatus.disconnected;
        },
      ),
    );
  }

  void send(WsOutgoingMessage message) {
    if (_channel == null) {
      _log.w('Cannot send message: not connected');
      return;
    }

    final messageJson = jsonEncode(message.toJson());
    _channel!.sink.add(messageJson);
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      Duration(seconds: 30),
      (_) => send(HeartbeatMessage()),
    );
  }

  void sendPlaybackUpdate({
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

    send(UpdatePlaybackMessage(payload));
  }

  void requestSync() {
    send(SyncRequestMessage());
  }

  String _buildWebSocketUrl(String roomId, String authToken) {
    final baseUrl = ApiConfig.baseUrl;
    final wsProtocol = baseUrl.startsWith('https') ? 'wss' : 'ws';
    final cleanUrl = baseUrl.replaceFirst(RegExp(r'^https?://'), '');
    return '$wsProtocol://$cleanUrl/rooms/$roomId/ws?authToken=$authToken';
  }

  void dispose() {
    _heartbeatTimer?.cancel();
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    _channel?.sink.close();
    _messageController.close();
    connectionStatus.dispose();
  }
}
