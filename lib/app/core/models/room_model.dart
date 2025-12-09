import 'package:roomy/app/core/models/playback_state_model.dart';

class RoomModel {
  final String id;
  final String name;
  final String hostId;
  final bool isPublic;
  final int maxParticipants;
  final DateTime createdAt;

  RoomModel({
    required this.id,
    required this.name,
    required this.hostId,
    required this.isPublic,
    required this.maxParticipants,
    required this.createdAt,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['roomId'] as String,
      name: json['name'] as String,
      hostId: json['hostId'] as String,
      isPublic: json['isPublic'] as bool,
      maxParticipants: json['maxParticipants'] as int,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': id,
      'name': name,
      'hostId': hostId,
      'isPublic': isPublic,
      'maxParticipants': maxParticipants,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, hostId: $hostId, isPublic: $isPublic, maxParticipants: $maxParticipants, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class RoomFullStateModel {
  final RoomModel room;
  final List<String> members;
  final PlaybackStateModel? playbackState;

  RoomFullStateModel({
    required this.room,
    required this.members,
    this.playbackState,
  });

  factory RoomFullStateModel.fromJson(Map<String, dynamic> json) {
    return RoomFullStateModel(
      room: RoomModel.fromJson(json),
      members: (json['members'] as List).cast<String>(),
      playbackState: json['playbackState'] != null
          ? PlaybackStateModel.fromJson(json['playbackState'])
          : null,
    );
  }

  String get roomId => room.id;
  String get hostId => room.hostId;
  bool isHost(String userId) => room.hostId == userId;
  bool isMember(String userId) => members.contains(userId);
}
