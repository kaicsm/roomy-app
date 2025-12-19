import 'package:flutter/material.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/room_model.dart';
import 'package:roomy/app/core/services/room_service.dart';
import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:signals/signals_flutter.dart';

class SelectPlatformController extends AppController {
  final _roomService = getIt<RoomService>();

  final selectedPlatform = signal('');
  final isLoading = signal(false);
  final mediaUrl = signal<String?>(null);

  final mediaUrlController = TextEditingController();

  SelectPlatformController() {
    mediaUrlController.addListener(() {
      mediaUrl.value = mediaUrlController.text;
    });
  }

  Future<RoomModel?> createRoom() async {
    isLoading.set(true);

    final result = await _roomService.createRoom(
      "Room",
      mediaUrl: mediaUrlController.text,
    );

    switch (result) {
      case Success(data: final room):
        isLoading.set(false);
        return room;
      case Failure():
        isLoading.set(false);
        return null;
    }
  }

  void togglePlatformSelection(String platform) {
    if (selectedPlatform.value == platform) {
      selectedPlatform.value = '';
    } else {
      selectedPlatform.value = platform;
    }
  }

  void clearPlatformSelection() {
    selectedPlatform.value = '';
  }

  @override
  void dispose() {
    selectedPlatform.dispose();
    mediaUrlController.dispose();
    isLoading.dispose();
  }
}
