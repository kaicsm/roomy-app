import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/auth/controllers/login_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class LoginView extends AppView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, LoginController controller) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: .all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text("Roomy", style: Theme.of(context).textTheme.titleLarge),
              Text("Login to your account", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Column(
                mainAxisAlignment: .center,
                children: [
                  // Username
                  TextField(
                    onChanged: controller.username.set,
                    decoration: InputDecoration(label: Text("Username")),
                  ),
                  const SizedBox(height: 12),

                  // Password
                  TextField(
                    onChanged: controller.password.set,
                    decoration: InputDecoration(
                      label: Text("Password"),
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

                  // Login button
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
                        final response = await controller.login();
                        if (response) {
                          context.mounted ? context.go(AppRoutes.home) : null;
                        }
                      },
                      child: controller.isLoading.watch(context)
                          ? CircularProgressIndicator()
                          : Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      context.push(AppRoutes.register);
                    },
                    child: Text("Don't have an account? Register"),
                  ),
                  const SizedBox(height: 12),

                  // Error message
                  controller.errorMessage.watch(context) != null
                      ? Text(
                          "${controller.errorMessage.watch(context)}",
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
