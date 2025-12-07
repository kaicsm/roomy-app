import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/room/controllers/room_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class RoomView extends AppView<RoomController> {
  const RoomView(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, RoomController controller) {
    return FutureBuilder(
      future: controller.initialize(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.go(AppRoutes.home),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text("Room"),
          ),
          body: SafeArea(
            child: Center(
              child: controller.isPlayerReady.watch(context)
                  ? Video(controller: controller.videoController)
                  : const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
