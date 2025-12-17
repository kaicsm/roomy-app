import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/app_theme.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/auth/controllers/login_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class LoginView extends AppView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, LoginController controller) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height)),
          child: const Text('Roomy'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome Back
                Text(
                  "Welcome Back!",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Log in to continue your watch party",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: Color(0xFFA8A8B3),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Username Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      onChanged: controller.username.set,
                      decoration: InputDecoration(
                        errorText:
                            controller.submitted.watch(context) &&
                                !controller.isUsernameValid
                            ? "Invalid username"
                            : null,
                        hintText: "Enter your username",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Password Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      onChanged: controller.password.set,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        errorText:
                            controller.submitted.watch(context) &&
                                !controller.isPasswordValid
                            ? "Invalid password"
                            : null,
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => controller.obscurePassword.set(
                            !controller.obscurePassword.value,
                          ),
                          icon: controller.obscurePassword.watch(context)
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                      obscureText: controller.obscurePassword.watch(context),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    style: ButtonStyle(overlayColor: .all(Colors.transparent)),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.watch(context)
                        ? null
                        : () async {
                            final response = await controller.login();
                            if (response && context.mounted) {
                              context.go(AppRoutes.home);
                            }
                          },
                    child: controller.isLoading.watch(context)
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Color(0xFF6B6B7B), fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(AppRoutes.signup);
                      },
                      style: ButtonStyle(
                        padding: .all(.all(0)),
                        overlayColor: .all(Colors.transparent),
                      ),
                      child: Text("Sign Up", style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Error message
                if (controller.errorMessage.watch(context) != null)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6B9D).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFFF6B9D).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Color(0xFFFF6B9D),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "${controller.errorMessage.watch(context)}",
                            style: TextStyle(
                              color: Color(0xFFFF6B9D),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
