import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/auth/controllers/register_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class RegisterView extends AppView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, RegisterController controller) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: .all(16.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text("Create a new account", style: TextStyle(fontSize: 22)),
                const SizedBox(height: 12),
                Column(
                  mainAxisAlignment: .center,
                  children: [
                    // Username
                    TextField(
                      onChanged: controller.username.set,
                      decoration: InputDecoration(hintText: "Username"),
                    ),
                    const SizedBox(height: 12),

                    // Email
                    TextField(
                      onChanged: controller.email.set,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(height: 12),

                    // Password
                    TextField(
                      onChanged: controller.password.set,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () => controller.obscurePassword.set(
                            !controller.obscurePassword.value,
                          ),
                          icon: controller.obscurePassword.watch(context)
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                      obscureText: controller.obscurePassword.watch(context),
                    ),
                    const SizedBox(height: 12),

                    // Register button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(borderRadius: .circular(12)),
                          ),
                        ),
                        onPressed: () async {
                          final response = await controller.register();
                          if (response) {
                            context.mounted ? context.go(AppRoutes.home) : null;
                          }
                        },
                        child: controller.isLoading.watch(context)
                            ? CircularProgressIndicator()
                            : Text("Register"),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Error message
                    controller.errorMessage.watch(context) != null
                        ? Text(
                            "${controller.errorMessage.value}",
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
