import 'package:flutter/material.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends AppView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: FilledButton(
        onPressed: () async => await controller.logout(),
        child: Text("Logout"),
      ),
    );
  }
}
