import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/home/controllers/platform_webview_controller.dart';
import 'package:signals/signals_flutter.dart';

class PlatformWebviewView extends AppView<PlatformWebviewController> {
  const PlatformWebviewView(this.platform, {super.key});

  final String platform;

  @override
  PlatformWebviewController getController(BuildContext context) {
    return PlatformWebviewController(platform);
  }

  @override
  Widget build(BuildContext context, PlatformWebviewController controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getPlatformName(platform)),
        actions: [
          IconButton(
            onPressed: controller.canGoBack.watch(context)
                ? controller.goBack
                : null,
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: controller.canGoForward.watch(context)
                ? controller.goForward
                : null,
            icon: const Icon(Icons.arrow_forward),
          ),
          IconButton(
            onPressed: controller.reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (controller.isLoading.watch(context))
              LinearProgressIndicator(
                value: controller.progress.watch(context),
                minHeight: 2,
              ),

            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(controller.getInitialUrl()),
                ),
                initialSettings: controller.settings,

                onWebViewCreated: (webController) {
                  controller.onWebViewCreated(webController);
                },

                onLoadStart: (webController, url) {
                  controller.isLoading.value = true;
                  controller.updateState(url?.toString());
                },

                onLoadStop: (webController, url) {
                  controller.isLoading.value = false;
                  controller.updateState(url?.toString());
                },

                onProgressChanged: (webController, progress) {
                  controller.progress.value = progress / 100;
                  if (progress == 100) {
                    controller.isLoading.value = false;
                  }
                },

                onUpdateVisitedHistory: (webController, url, isReload) {
                  controller.updateState(url?.toString());
                },
              ),
            ),

            _buildBottomControlPanel(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControlPanel(
    BuildContext context,
    PlatformWebviewController controller,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.currentUrl.watch(context) != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      controller.currentUrl.watch(context)!,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                final room = await controller.createRoom();

                if (room != null && context.mounted) {
                  context.go('/room/${room.id}');
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Failed to create room or invalid URL',
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              child: const Text('Use This Media'),
            ),
          ),
        ],
      ),
    );
  }

  String _getPlatformName(String platform) {
    switch (platform) {
      case 'youtube':
        return 'YouTube';
      case 'netflix':
        return 'Netflix';
      case 'drive':
        return 'Google Drive';
      case 'web':
        return 'Web';
      default:
        return 'Browser';
    }
  }
}
