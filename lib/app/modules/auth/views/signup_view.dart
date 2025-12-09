import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roomy/app/config/app_theme.dart';
import 'package:roomy/app/core/utils/app_view.dart';
import 'package:roomy/app/modules/auth/controllers/signup_controller.dart';
import 'package:roomy/app/router/app_routes.dart';
import 'package:signals/signals_flutter.dart';

class SignupView extends AppView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, SignupController controller) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height)),
          child: Text('Roomy'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Column(
                  children: [
                    Text(
                      "Grab a Seat!",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Create an account to start watching\nmovies with your friends",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        color: Color(0xFFA8A8B3),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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

                // Email Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Address",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      onChanged: controller.email.set,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorText:
                            controller.submitted.watch(context) &&
                                !controller.isEmailValid
                            ? "Invalid email"
                            : null,
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.email_outlined),
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
                        errorText:
                            controller.submitted.watch(context) &&
                                !controller.isPasswordValid
                            ? "Invalid password"
                            : null,
                        hintText: "Create a password",
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

                const SizedBox(height: 20),

                // Terms & Conditions Checkbox
                Row(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    Checkbox(
                      value: controller.termsCheck.watch(context),
                      onChanged: (value) => controller.termsCheck.set(value!),

                      side:
                          controller.submitted.watch(context) &&
                              !controller.isTermsAccepted
                          ? BorderSide(color: Colors.red, width: 2)
                          : null,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Color(0xFF6B6B7B),
                            fontSize: 13,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(text: "I agree to the "),
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                color: Color(0xFF6C5CE7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: Color(0xFF6C5CE7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: "."),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.watch(context)
                        ? null
                        : () async {
                            final response = await controller.register();
                            if (response && context.mounted) {
                              context.go(AppRoutes.home);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: controller.isLoading.watch(context)
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
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
