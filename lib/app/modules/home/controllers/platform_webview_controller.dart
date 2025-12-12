import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/room_model.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class PlatformWebviewController extends AppController {
  final _roomService = getIt<RoomService>();

  final String platform;
  InAppWebViewController? webViewController;

  final isLoading = signal(true);
  final progress = signal(0.0);
  final canGoBack = signal(false);
  final canGoForward = signal(false);
  final currentUrl = signal<String?>(null);

  final settings = InAppWebViewSettings(
    isInspectable: true,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
    userAgent:
        "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.6261.112 Mobile Safari/537.36",
  );

  PlatformWebviewController(this.platform);

  String getInitialUrl() {
    switch (platform) {
      case 'youtube':
        return 'https://www.youtube.com';
      case 'netflix':
        return 'https://www.netflix.com';
      case 'drive':
        return 'https://drive.google.com';
      case 'web':
        return 'https://google.com';
      default:
        return 'https://google.com';
    }
  }

  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
  }

  void updateState(String? url) async {
    if (url != null) currentUrl.value = url;

    if (webViewController != null) {
      canGoBack.value = await webViewController!.canGoBack();
      canGoForward.value = await webViewController!.canGoForward();
    }
  }

  void goBack() async {
    if (webViewController != null && await webViewController!.canGoBack()) {
      webViewController!.goBack();
    }
  }

  void goForward() async {
    if (webViewController != null && await webViewController!.canGoForward()) {
      webViewController!.goForward();
    }
  }

  void reload() {
    webViewController?.reload();
  }

  Future<String?> extractVideoSource() async {
    final current = currentUrl.value;
    if (current == null) return null;

    if (platform == 'youtube' ||
        current.contains('youtube.com') ||
        current.contains('youtu.be')) {
      String? videoId;

      final regExp = RegExp(
        r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?)|(shorts\/))\??v?=?([^#&?]*).*',
      );

      final match = regExp.firstMatch(current);
      if (match != null && match.group(8) != null) {
        videoId = match.group(8);
      }

      if (videoId != null && videoId.isNotEmpty) {
        return 'https://www.youtube.com/watch?v=$videoId';
      }
    }

    if (webViewController != null) {
      try {
        final result = await webViewController!.evaluateJavascript(
          source: """
            (function() {
              var video = document.querySelector('video');
              // Prioriza src direto, evita blob se possível, mas pega o que tiver
              return video ? (video.currentSrc || video.src) : null;
            })();
          """,
        );

        if (result != null &&
            result.toString().isNotEmpty &&
            !result.toString().startsWith('blob:')) {
          return result.toString();
        }
      } catch (e) {
        debugPrint('Erro ao extrair JS: $e');
      }
    }

    return current;
  }

  Future<RoomModel?> createRoom() async {
    final effectiveMediaUrl = await extractVideoSource();

    if (effectiveMediaUrl == null) return null;

    final result = await _roomService.createRoom(
      "Room ${platform.toUpperCase()}",
      mediaUrl: effectiveMediaUrl,
      mediaType: platform,
    );

    switch (result) {
      case Success(data: final room):
        return room;
      case Failure():
        return null;
    }
  }

  @override
  void dispose() {
    isLoading.dispose();
    progress.dispose();
    canGoBack.dispose();
    canGoForward.dispose();
    currentUrl.dispose();
  }
}
