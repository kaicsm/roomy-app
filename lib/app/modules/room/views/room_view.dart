import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:roomy/app/config/app_theme.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/room/controllers/room_controller.dart';
import 'package:roomy/app/modules/room/widgets/player.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class RoomView extends AppView<RoomController> {
  const RoomView(this.id, {super.key});

  final String id;

  @override
  RoomController getController(BuildContext context) {
    return RoomController(id);
  }

  @override
  Widget build(BuildContext context, RoomController controller) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go(AppRoutes.home),
          icon: const Icon(Icons.arrow_back),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height)),
          child: const Text('Roomy'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(controller.connectionStatus.watch(context)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: Builder(
                  builder: (context) {
                    final isLoading = controller.isLoading.watch(context);
                    final currentUrl = controller.currentUrl.watch(context);

                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final videoCtrl = controller.videoController;
                    if (currentUrl.isNotEmpty) {
                      return Video(
                        controller: videoCtrl,
                        controls: (state) => playerControls(state, controller),
                      );
                    }

                    return const Center(
                      child: Text(
                        "Waiting for media...",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Builder(
                builder: (context) {
                  final currentUrl = controller.currentUrl.watch(context);
                  return Center(
                    child: Text(
                      currentUrl.isEmpty
                          ? "No media selected"
                          : "Playing: $currentUrl",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
