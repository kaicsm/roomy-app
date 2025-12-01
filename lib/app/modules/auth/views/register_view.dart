import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/modules/auth/controllers/register_controller.dart';
import 'package:signals/signals_flutter.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _controller = getIt<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: .circular(12)),
                        label: Text("Username"),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      onChanged: _controller.email.set,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: .circular(12)),
                        label: Text("Email"),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      onChanged: _controller.password.set,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: .circular(12)),
                        label: Text("Password"),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    Watch(
                      (context) => SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: .circular(12),
                              ),
                            ),
                            padding: WidgetStatePropertyAll(.all(20)),
                          ),
                          onPressed: () async {
                            await _controller.register();
                            context.mounted ? context.go("/") : null;
                          },
                          child: Text("Register"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        context.go("/auth/login");
                      },
                      child: Text("Already has an account? Login"),
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
