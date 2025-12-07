import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/home/controllers/create_room_controller.dart';
import 'package:signals/signals_flutter.dart';

class CreateRoomView extends AppView<CreateRoomController> {
  const CreateRoomView({super.key});

  @override
  Widget build(BuildContext context, CreateRoomController controller) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Room")),
      body: SafeArea(
        child: Padding(
          padding: .all(12),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              TextField(
                onChanged: controller.name.set,
                decoration: InputDecoration(label: Text("Name")),
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (value) =>
                    controller.maxParticipants.value = int.parse(value),
                decoration: InputDecoration(label: Text("Max participants")),
                keyboardType: .number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text("Public"),
                  const SizedBox(width: 12),
                  Switch(
                    value: controller.isPublic.watch(context),
                    onChanged: controller.isPublic.set,
                  ),
                ],
              ),

              const SizedBox(height: 12),
              FilledButton(
                onPressed: () async {
                  final room = await controller.createRoom();
                  if (room != null && context.mounted) {
                    context.pushReplacement('/room/${room.id}');
                  }
                },
                child: Text("Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
