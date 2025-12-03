import 'package:flutter/material.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final _controller = getIt<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: FilledButton(
        onPressed: () async => await _controller.logout(),
        child: Text("Logout"),
      ),
    );
  }
}
