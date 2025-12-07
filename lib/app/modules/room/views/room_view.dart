import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/room/controllers/room_controller.dart';
import 'package:roomy/app/router/app_routes.dart';

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
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Room"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 220,
              child: Video(controller: controller.videoController),
            ),
          ],
        ),
      ),
    );
  }
}
