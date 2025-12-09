class PlaybackStateModel {
  final String mediaUrl;
  final String mediaType;
  final bool isPlaying;
  final double currentTime;
  final double playbackSpeed;
  final String lastUpdatedBy;
  final DateTime lastUpdated;

  PlaybackStateModel({
    required this.mediaUrl,
    required this.mediaType,
    required this.isPlaying,
    required this.currentTime,
    required this.playbackSpeed,
    required this.lastUpdatedBy,
    required this.lastUpdated,
  });

  factory PlaybackStateModel.fromJson(Map<String, dynamic> json) {
    return PlaybackStateModel(
      mediaUrl: json['mediaUrl'] as String,
      mediaType: json['mediaType'] as String,
      isPlaying: json['isPlaying'] as bool,
      currentTime: (json['currentTime'] as num).toDouble(),
      playbackSpeed: (json['playbackSpeed'] as num).toDouble(),
      lastUpdatedBy: json['lastUpdatedBy'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'isPlaying': isPlaying,
      'currentTime': currentTime,
      'playbackSpeed': playbackSpeed,
      'lastUpdatedBy': lastUpdatedBy,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  PlaybackStateModel copyWith({
    String? mediaUrl,
    String? mediaType,
    bool? isPlaying,
    double? currentTime,
    double? playbackSpeed,
    String? lastUpdatedBy,
    DateTime? lastUpdated,
  }) {
    return PlaybackStateModel(
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      isPlaying: isPlaying ?? this.isPlaying,
      currentTime: currentTime ?? this.currentTime,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
