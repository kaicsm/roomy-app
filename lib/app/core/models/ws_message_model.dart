import 'package:roomy/app/core/models/playback_state_model.dart';
import 'package:roomy/app/core/models/room_model.dart';

enum WsIncomingMessageType {
  playbackUpdated,
  userJoined,
  userLeft,
  hostChanged,
  syncFullState,
  error,
}

enum WsOutgoingMessageType { updatePlayback, syncRequest, heartbeat }

abstract class WsIncomingMessage {
  final WsIncomingMessageType type;

  WsIncomingMessage(this.type);

  factory WsIncomingMessage.fromJson(Map<String, dynamic> json) {
    final type = _parseIncomingType(json['type'] as String);

    switch (type) {
      case WsIncomingMessageType.playbackUpdated:
        return PlaybackUpdatedMessage.fromJson(json);
      case WsIncomingMessageType.userJoined:
        return UserJoinedMessage.fromJson(json);
      case WsIncomingMessageType.userLeft:
        return UserLeftMessage.fromJson(json);
      case WsIncomingMessageType.hostChanged:
        return HostChangedMessage.fromJson(json);
      case WsIncomingMessageType.syncFullState:
        return SyncFullStateMessage.fromJson(json);
      case WsIncomingMessageType.error:
        return ErrorMessage.fromJson(json);
    }
  }

  static WsIncomingMessageType _parseIncomingType(String type) {
    switch (type) {
      case 'PLAYBACK_UPDATED':
        return WsIncomingMessageType.playbackUpdated;
      case 'USER_JOINED':
        return WsIncomingMessageType.userJoined;
      case 'USER_LEFT':
        return WsIncomingMessageType.userLeft;
      case 'HOST_CHANGED':
        return WsIncomingMessageType.hostChanged;
      case 'SYNC_FULL_STATE':
        return WsIncomingMessageType.syncFullState;
      case 'ERROR':
        return WsIncomingMessageType.error;
      default:
        throw Exception('Unknown message type: $type');
    }
  }
}

class PlaybackUpdatedMessage extends WsIncomingMessage {
  final PlaybackStateModel payload;

  PlaybackUpdatedMessage(this.payload)
    : super(WsIncomingMessageType.playbackUpdated);

  factory PlaybackUpdatedMessage.fromJson(Map<String, dynamic> json) {
    return PlaybackUpdatedMessage(PlaybackStateModel.fromJson(json['payload']));
  }
}

class UserJoinedMessage extends WsIncomingMessage {
  final String userId;
  final int memberCount;

  UserJoinedMessage({required this.userId, required this.memberCount})
    : super(WsIncomingMessageType.userJoined);

  factory UserJoinedMessage.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return UserJoinedMessage(
      userId: payload['userId'] as String,
      memberCount: payload['memberCount'] as int,
    );
  }
}

class UserLeftMessage extends WsIncomingMessage {
  final String userId;
  final int memberCount;

  UserLeftMessage({required this.userId, required this.memberCount})
    : super(WsIncomingMessageType.userLeft);

  factory UserLeftMessage.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return UserLeftMessage(
      userId: payload['userId'] as String,
      memberCount: payload['memberCount'] as int,
    );
  }
}

class HostChangedMessage extends WsIncomingMessage {
  final String newHostId;

  HostChangedMessage(this.newHostId) : super(WsIncomingMessageType.hostChanged);

  factory HostChangedMessage.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return HostChangedMessage(payload['newHostId'] as String);
  }
}

class SyncFullStateMessage extends WsIncomingMessage {
  final RoomFullStateModel payload;

  SyncFullStateMessage(this.payload)
    : super(WsIncomingMessageType.syncFullState);

  factory SyncFullStateMessage.fromJson(Map<String, dynamic> json) {
    return SyncFullStateMessage(RoomFullStateModel.fromJson(json['payload']));
  }
}

class ErrorMessage extends WsIncomingMessage {
  final String message;

  ErrorMessage(this.message) : super(WsIncomingMessageType.error);

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(json['payload'] as String);
  }
}

abstract class WsOutgoingMessage {
  final WsOutgoingMessageType type;

  WsOutgoingMessage(this.type);

  Map<String, dynamic> toJson();
}

class UpdatePlaybackMessage extends WsOutgoingMessage {
  final Map<String, dynamic> payload;

  UpdatePlaybackMessage(this.payload)
    : super(WsOutgoingMessageType.updatePlayback);

  @override
  Map<String, dynamic> toJson() {
    return {'type': 'UPDATE_PLAYBACK', 'payload': payload};
  }
}

class SyncRequestMessage extends WsOutgoingMessage {
  SyncRequestMessage() : super(WsOutgoingMessageType.syncRequest);

  @override
  Map<String, dynamic> toJson() {
    return {'type': 'SYNC_REQUEST'};
  }
}

class HeartbeatMessage extends WsOutgoingMessage {
  HeartbeatMessage() : super(WsOutgoingMessageType.heartbeat);

  @override
  Map<String, dynamic> toJson() {
    return {'type': 'HEARTBEAT'};
  }
}