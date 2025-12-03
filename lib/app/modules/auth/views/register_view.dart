import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/modules/auth/controllers/register_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _controller = getIt<RegisterController>();

  @override
  Widget build(BuildContext context) {
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
                    TextField(
                      onChanged: _controller.username.set,
                      decoration: InputDecoration(label: Text("Username")),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      onChanged: _controller.email.set,
                      decoration: InputDecoration(label: Text("Email")),
                    ),
                    const SizedBox(height: 12),
                    Watch(
                      (context) => TextField(
                        onChanged: _controller.password.set,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          suffixIcon: IconButton(
                            onPressed: () => _controller.obscurePassword.value =
                                !_controller.obscurePassword.value,
                            icon: _controller.obscurePassword.value
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                        obscureText: _controller.obscurePassword.value,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Watch(
                      (context) => SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: .circular(12),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final response = await _controller.register();
                            if (response) {
                              context.mounted
                                  ? context.go(AppRoutes.home)
                                  : null;
                            }
                          },
                          child: _controller.isLoading.value
                              ? CircularProgressIndicator()
                              : Text("Register"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Watch(
                      (context) => _controller.errorMessage.value != null
                          ? Text(
                              "${_controller.errorMessage.value}",
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox.shrink(),
                    ),
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
