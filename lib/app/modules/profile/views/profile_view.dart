import 'package:flutter/material.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/profile/controllers/profile_controller.dart';
import 'package:roomy/app/widgets/title_widget.dart';

class ProfileView extends AppView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget('Profile'),
        actions: [
          IconButton(
            onPressed: () async => await controller.logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Container(
                width: 144,
                height: 144,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF252637),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 72,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '@${controller.user.username}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
