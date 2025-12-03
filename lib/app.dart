import 'package:flutter/material.dart';
import 'package:roomy/app/config/app_theme.dart';
import 'package:roomy/app/router/app_router.dart';

class RoomyApp extends StatelessWidget {
  const RoomyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: .dark,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
