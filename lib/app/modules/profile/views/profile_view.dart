import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final _controller = getIt<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "appTitle",
          child: Material(
            type: .transparency,
            child: Text(
              "Profile",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: FilledButton(
        onPressed: () async => await _controller.logout(),
        child: Text("Logout"),
      ),
    );
  }
}
