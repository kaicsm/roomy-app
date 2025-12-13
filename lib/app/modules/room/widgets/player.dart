import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/extensions/duration.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';
import 'package:roomy/app/modules/room/controllers/room_controller.dart';
import 'package:signals/signals_flutter.dart';

Widget playerControls(VideoState state, RoomController roomController) {
  return _PlayerControls(roomController);
}

class _PlayerControls extends StatefulWidget {
  const _PlayerControls(this.roomController);

  final RoomController roomController;

  @override
  State<_PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<_PlayerControls> with SignalsMixin {
  late final visible = signal(false);
  Timer? _hideTimer;

  late final position = signal(Duration.zero);
  late final duration = signal(Duration.zero);
  late final buffer = signal(Duration.zero);
  late final playing = signal(false);
  late final buffering = signal(false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    position.value = controller(context).player.state.position;
    duration.value = controller(context).player.state.duration;
    buffer.value = controller(context).player.state.buffer;
    playing.value = controller(context).player.state.playing;
    buffering.value = controller(context).player.state.buffering;

    controller(context).player.stream.position.listen((event) {
      position.value = event;
    });
    controller(context).player.stream.duration.listen((event) {
      duration.value = event;
    });
    controller(context).player.stream.buffer.listen((event) {
      buffer.value = event;
    });
    controller(context).player.stream.playing.listen((event) {
      playing.value = event;
    });
    controller(context).player.stream.buffering.listen((event) {
      buffering.value = event;
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _toggleControls() {
    visible.value = !visible.value;
    if (visible.value) {
      _resetHideTimer();
    }
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (playing.value) {
        visible.value = false;
      }
    });
  }

  void _togglePlayPause() {
    widget.roomController.onPlayPause();
    _resetHideTimer();
  }

  void _seekBackward() {
    final newPos = position.value - const Duration(seconds: 10);
    widget.roomController.onSeek(newPos);
    _resetHideTimer();
  }

  void _seekForward() {
    final newPos = position.value + const Duration(seconds: 10);
    widget.roomController.onSeek(newPos);
    _resetHideTimer();
  }

  double get _positionPercent {
    if (position.value == Duration.zero || duration.value == Duration.zero) {
      return 0.0;
    }
    return (position.value.inMilliseconds / duration.value.inMilliseconds)
        .clamp(0.0, 1.0);
  }

  double get _bufferPercent {
    if (buffer.value == Duration.zero || duration.value == Duration.zero) {
      return 0.0;
    }
    return (buffer.value.inMilliseconds / duration.value.inMilliseconds).clamp(
      0.0,
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _toggleControls,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          // Buffering Indicator
          if (buffering.watch(context))
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                  strokeWidth: 2,
                ),
              ),
            ),

          // Controls Overlay
          AnimatedOpacity(
            opacity: visible.watch(context) ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Control Buttons
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ControlButton(
                          icon: Icons.replay_10_rounded,
                          onPressed: _seekBackward,
                          size: 36,
                        ),
                        const SizedBox(width: 24),
                        _ControlButton(
                          icon: playing.watch(context)
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          onPressed: _togglePlayPause,
                          size: 52,
                          isPrimary: true,
                        ),
                        const SizedBox(width: 24),
                        _ControlButton(
                          icon: Icons.forward_10_rounded,
                          onPressed: _seekForward,
                          size: 36,
                        ),
                      ],
                    ),
                  ),

                  // Seek Bar & Bottom Info
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${position.watch(context).label(reference: duration.value)} / ${duration.watch(context).label(reference: duration.value)}',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 11,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  toggleFullscreen(context);
                                  _resetHideTimer();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    isFullscreen(context)
                                        ? Icons.fullscreen_exit_rounded
                                        : Icons.fullscreen_rounded,
                                    color: theme.colorScheme.onSurface,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _SeekBar(
                            position: position.watch(context),
                            duration: duration.watch(context),
                            buffer: buffer.watch(context),
                            positionPercent: _positionPercent,
                            bufferPercent: _bufferPercent,
                            onSeek: (percent) {
                              final newPos = duration.value * percent;
                              widget.roomController.onSeek(newPos);
                              _resetHideTimer();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final bool isPrimary;

  const _ControlButton({
    required this.icon,
    required this.onPressed,
    this.size = 32,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isPrimary
              ? theme.colorScheme.primary.withValues(alpha: 0.9)
              : Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: theme.colorScheme.onPrimary,
          size: size * 0.55,
        ),
      ),
    );
  }
}

class _SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final Duration buffer;
  final double positionPercent;
  final double bufferPercent;
  final Function(double) onSeek;

  const _SeekBar({
    required this.position,
    required this.duration,
    required this.buffer,
    required this.positionPercent,
    required this.bufferPercent,
    required this.onSeek,
  });

  @override
  State<_SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<_SeekBar> with SignalsMixin {
  late final isDragging = signal(false);
  late final dragValue = signal(0.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onHorizontalDragStart: (details) {
        isDragging.value = true;
      },
      onHorizontalDragUpdate: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final percent = (details.localPosition.dx / box.size.width).clamp(
            0.0,
            1.0,
          );
          dragValue.value = percent;
        }
      },
      onHorizontalDragEnd: (details) {
        widget.onSeek(dragValue.value);
        isDragging.value = false;
      },
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final percent = (details.localPosition.dx / box.size.width).clamp(
            0.0,
            1.0,
          );
          widget.onSeek(percent);
        }
      },
      child: Container(
        height: 24,
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final currentPercent = isDragging.watch(context)
                ? dragValue.watch(context)
                : widget.positionPercent;

            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Background Track
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
                // Buffer Track
                FractionallySizedBox(
                  widthFactor: widget.bufferPercent,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
                // Progress Track
                FractionallySizedBox(
                  widthFactor: currentPercent,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primaryContainer,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(1.5),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.5,
                          ),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                // Thumb
                Positioned(
                  left: (currentPercent * constraints.maxWidth) - 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 3,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
