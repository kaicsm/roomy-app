import 'package:roomy/app/core/models/playback_state_model.dart';
import 'package:roomy/app/core/models/room_model.dart';

enum WsIncomingMessageType { updatePlayback, syncRequest, heartbeat }

enum WsOutgoingMessageType {
  playbackUpdated,
  userJoined,
  userLeft,
  hostChanged,
  syncFullState,
  error,
}

abstract class WsOutgoingMessage {
  final WsOutgoingMessageType type;

  WsOutgoingMessage(this.type);

  factory WsOutgoingMessage.fromJson(Map<String, dynamic> json) {
    final type = _parseOutgoingType(json['type'] as String);

    switch (type) {
      case WsOutgoingMessageType.playbackUpdated:
        return PlaybackUpdatedMessage.fromJson(json);
      case WsOutgoingMessageType.userJoined:
        return UserJoinedMessage.fromJson(json);
      case WsOutgoingMessageType.userLeft:
        return UserLeftMessage.fromJson(json);
      case WsOutgoingMessageType.hostChanged:
        return HostChangedMessage.fromJson(json);
      case WsOutgoingMessageType.syncFullState:
        return SyncFullStateMessage.fromJson(json);
      case WsOutgoingMessageType.error:
        return ErrorMessage.fromJson(json);
    }
  }

  static WsOutgoingMessageType _parseOutgoingType(String type) {
    switch (type) {
      case 'PLAYBACK_UPDATED':
        return WsOutgoingMessageType.playbackUpdated;
      case 'USER_JOINED':
        return WsOutgoingMessageType.userJoined;
      case 'USER_LEFT':
        return WsOutgoingMessageType.userLeft;
      case 'HOST_CHANGED':
        return WsOutgoingMessageType.hostChanged;
      case 'SYNC_FULL_STATE':
        return WsOutgoingMessageType.syncFullState;
      case 'ERROR':
        return WsOutgoingMessageType.error;
      default:
        throw Exception('Unknown message type: $type');
    }
  }
}

class PlaybackUpdatedMessage extends WsOutgoingMessage {
  final PlaybackStateModel payload;

  PlaybackUpdatedMessage(this.payload)
    : super(WsOutgoingMessageType.playbackUpdated);

  factory PlaybackUpdatedMessage.fromJson(Map<String, dynamic> json) {
    return PlaybackUpdatedMessage(PlaybackStateModel.fromJson(json['payload']));
  }
}

class UserJoinedMessage extends WsOutgoingMessage {
  final String userId;
  final int memberCount;

  UserJoinedMessage({required this.userId, required this.memberCount})
    : super(WsOutgoingMessageType.userJoined);

  factory UserJoinedMessage.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return UserJoinedMessage(
      userId: payload['userId'] as String,
      memberCount: payload['memberCount'] as int,
    );
  }
}

class UserLeftMessage extends WsOutgoingMessage {
  final String userId;
  final int memberCount;

  UserLeftMessage({required this.userId, required this.memberCount})
    : super(WsOutgoingMessageType.userLeft);

  factory UserLeftMessage.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return UserLeftMessage(
      userId: payload['userId'] as String,
      memberCount: payload['memberCount'] as int,
    );
  }
}

class HostChangedMessage extends WsOutgoingMessage {
  final String newHostId;

  HostChangedMessage(this.newHostId) : super(WsOutgoingMessageType.hostChanged);

  factory HostChangedMessage.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return HostChangedMessage(payload['newHostId'] as String);
  }
}

class SyncFullStateMessage extends WsOutgoingMessage {
  final RoomFullStateModel payload;

  SyncFullStateMessage(this.payload)
    : super(WsOutgoingMessageType.syncFullState);

  factory SyncFullStateMessage.fromJson(Map<String, dynamic> json) {
    return SyncFullStateMessage(RoomFullStateModel.fromJson(json['payload']));
  }
}

class ErrorMessage extends WsOutgoingMessage {
  final String message;

  ErrorMessage(this.message) : super(WsOutgoingMessageType.error);

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(json['payload'] as String);
  }
}

abstract class WsIncomingMessage {
  final WsIncomingMessageType type;

  WsIncomingMessage(this.type);

  Map<String, dynamic> toJson();
}

class UpdatePlaybackMessage extends WsIncomingMessage {
  final Map<String, dynamic> payload;

  UpdatePlaybackMessage(this.payload)
    : super(WsIncomingMessageType.updatePlayback);

  @override
  Map<String, dynamic> toJson() {
    return {'type': 'UPDATE_PLAYBACK', 'payload': payload};
  }
}

class SyncRequestMessage extends WsIncomingMessage {
  SyncRequestMessage() : super(WsIncomingMessageType.syncRequest);

  @override
  Map<String, dynamic> toJson() {
    return {'type': 'SYNC_REQUEST'};
  }
}

class HeartbeatMessage extends WsIncomingMessage {
  HeartbeatMessage() : super(WsIncomingMessageType.heartbeat);

  @override
  Map<String, dynamic> toJson() {
    return {'type': 'HEARTBEAT'};
  }
}
